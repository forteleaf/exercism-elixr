# RPN Calculator Inspection

Welcome to RPN Calculator Inspection on Exercism's Elixir Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Links

Elixir [processes][exercism-processes] are isolated and don't share anything by default. When an unlinked child process crashes, its parent process is not affected.

This behavior can be changed by _linking_ processes to one another. If two processes are linked, a failure in one process will be propagated to the other process. Links are **bidirectional**.

Processes can be spawned already linked to the calling process using `spawn_link/1` which is an atomic operation, or they can be linked later with `Process.link/1`.

Linking processes can be useful when doing parallelized work when each chunk of work shouldn't be continued in case another chunk fails to finish.

### Trapping exits

Linking can also be used for _supervising_ processes. If a process _traps exits_, it will not crash when a process to which it's linked crashes. It will instead receive a message about the crash. This allows it to deal with the crash gracefully, for example by restarting the crashed process.

A process can be configured to trap exits by calling `Process.flag(:trap_exit, true)`. Note that `Process.flag/2` returns the _old_ value of the flag, not the new one.

The message that will be sent to the process in case a linked process crashes will match the pattern `{:EXIT, from, reason}`, where `from` is a PID. If `reason` is anything other than the atom `:normal`, that means that the process crashed or was forcefully killed.

## Tasks

Tasks are [processes][exercism-processes] meant to execute one specific operation.
They usually don't communicate with other processes, but they can return a result to the process that started the task.

Tasks are commonly used to parallelize work.

### `async`/`await`

To start a task, use `Task.async/1`. It takes an anonymous function as an argument and executes it in a new process that is linked to the caller process. It returns a `%Task{}` struct.

To get the result of the execution, pass the `%Task{}` struct to `Task.await/2`. It will wait for the task to finish and return its result. The second argument is a timeout in milliseconds, defaulting to 5000.

Note that between starting the task and awaiting the task, the process that started the task is not blocked and might do other operations.

Any task started with `Task.async/1` should be awaited because it will send a message to the calling process. `Task.await/2` can be called for each task only once.

### `start`/`start_link`

If you want to start a task for side-effects only, use `Task.start/1` or `Task.start_link/1`. `Task.start/1` will start a task that is not linked to the calling process, and `Task.start_link/1` will start a task that is linked to the calling process. Both functions return a `{:ok, pid}` tuple.

[exercism-processes]: https://exercism.org/tracks/elixir/concepts/processes

## Instructions

Your work at _Instruments of Texas_ on an experimental RPN calculator continues. Your team has built a few prototypes that need to undergo a thorough inspection, to choose the best one that can be mass-produced.

You want to conduct two types of checks.

Firstly, a reliability check that will detect inputs for which the calculator under inspection either crashes or doesn't respond fast enough. To isolate failures, the calculations for each input need to be run in a separate process. Linking and trapping exits in the caller process can be used to detect if the calculation finished or crashed.

Secondly, a correctness check that will check if for a given input, the result returned by the calculator is as expected. Only calculators that already passed the reliability check will undergo a correctness check, so crashes are not a concern. However, the operations should be run concurrently to speed up the process, which makes it the perfect use case for asynchronous tasks.

텍사스의 _인스트루먼츠 오브 텍사스_에서 실험용 RPN 계산기에 대한 작업을 계속하고 있습니다. 팀은 대량 생산이 가능한 최고의 제품을 선택하기 위해 철저한 검사를 거쳐야 하는 몇 가지 프로토타입을 제작했습니다.

두 가지 유형의 검사를 수행하려고 합니다.

첫째, 검사 중인 계산기가 충돌하거나 충분히 빠르게 응답하지 않는 입력을 감지하는 신뢰성 검사입니다. 오류를 분리하려면 각 입력에 대한 계산을 별도의 프로세스에서 실행해야 합니다. 호출자 프로세스에서 출구를 연결하고 트래핑하면 계산이 완료되었는지 또는 충돌이 발생했는지 감지할 수 있습니다.

둘째, 주어진 입력에 대해 계산기가 반환한 결과가 예상한 것과 같은지 확인하는 정확성 검사. 이미 신뢰성 검사를 통과한 계산기만 정확성 검사를 거치기 때문에 충돌은 걱정할 필요가 없습니다. 그러나 프로세스 속도를 높이기 위해 연산을 동시에 실행해야 하므로 비동기 작업에 적합한 사용 사례입니다.

## 1. Start a reliability check for a single input

Implement the `RPNCalculatorInspection.start_reliability_check/2` function. It should take 2 arguments, a function (the calculator), and an input for the calculator. It should return a map that contains the input and the PID of the spawned process.

The spawned process should call the given calculator function with the given input. The process should be linked to the caller process.

RPNCalculatorInspection.start_reliability_check/2 함수를 구현합니다. 2개의 인수, 함수(계산기) 및 계산기에 대한 입력이 필요합니다. 생성된 프로세스의 입력과 PID가 포함된 맵을 반환해야 합니다.

생성된 프로세스는 주어진 입력으로 주어진 계산기 함수를 호출해야 합니다. 프로세스는 호출자 프로세스에 연결되어야 합니다.

```elixir
RPNCalculatorInspection.start_reliability_check(fn _ -> 0 end, "2 3 +")
# => %{input: "2 3 +", pid: #PID<0.169.0>}
```

## 2. Interpret the results of a reliability check

Implement the `RPNCalculatorInspection.await_reliability_check_result/2` function. It should take two arguments. The first argument is a map with the input of the reliability check and the PID of the process running the reliability check for this input, as returned by `RPNCalculatorInspection.start_reliability_check/2`. The second argument is a map that serves as an accumulator for the results of reliability checks with different inputs.

The function should wait for an exit message.

If it receives an exit message (`{:EXIT, from, reason}`) with the reason `:normal` from the same process that runs the reliability check, it should return the results map with the value `:ok` added under the key `input`.

If it receives an exit message with a different reason from the same process that runs the reliability check, it should return the results map with the value `:error` added under the key `input`.

If it doesn't receive any messages matching those criteria in 100ms, it should return the results map with the value `:timeout` added under t

RPNCalculatorInspection.await_reliability_check_result/2 함수를 구현합니다.
두 가지 인수가 필요합니다.
첫 번째 인수는 RPNCalculatorInspection.start_reliability_check/2에서 반환된 대로 신뢰성 검사 입력과 이 입력에 대한 신뢰성 검사를 실행하는 프로세스의 PID가 포함된 맵입니다.
두 번째 인수는 다양한 입력을 사용한 신뢰성 검사 결과에 대한 누산기 역할을 하는 맵입니다.

함수는 종료 메시지를 기다려야 합니다.

신뢰성 검사를 실행하는 동일한 프로세스로부터 이유가 :normal인 종료 메시지({:EXIT, from, Reason})를 수신하면 키 입력 아래에 :ok 값이 추가된 결과 맵을 반환해야 합니다.

신뢰성 검사를 실행하는 동일한 프로세스에서 다른 이유가 있는 종료 메시지를 받으면 키 입력 아래에 :error 값이 추가된 결과 맵을 반환해야 합니다.


100ms 내에 해당 기준과 일치하는 메시지를 받지 못하면 키 입력 아래에 :timeout 값이 추가된 결과 맵을 반환해야 합니다.he key `input`.

```elixir
# when an exit message is waiting for the process in its inbox
send(self(), {:EXIT, pid, :normal})

RPNCalculatorInspection.await_reliability_check_result(
  %{input: "5 7 -", pid: pid}, 
  %{}
)
# => %{"5 7 -" => :ok}

# when there are no messages in the process inbox
RPNCalculatorInspection.await_reliability_check_result(
  %{input: "3 2 *", pid: pid},
  %{"5 7 -" => :ok}
)
# => %{"5 7 -" => :ok, "3 2 *" => :timeout}
```

## 3. Run a concurrent reliability check for many inputs

Implement the `RPNCalculatorInspection.reliability_check/2` function. It should take 2 arguments, a function (the calculator), and a list of inputs for the calculator.

For every input on the list, it should start the reliability check in a new linked process by using `start_reliability_check/2`. Then, for every process started this way, it should await its results by using `await_reliability_check_result/2`.

Before starting any processes, the function needs to flag the current process to trap exits, to be able to receive exit messages. Afterwards, it should reset this flag to its original value.

The function should return a map with the results of reliability checks of all the inputs.

```elixir
fake_broken_calculator = fn input ->
  if String.ends_with?(input, "*"), do: raise "oops"
end

inputs = ["2 3 +", "10 3 *", "20 2 /"]

RPNCalculatorInspection.reliability_check(fake_broken_calculator, inputs)
# => %{
#       "2 3 +" => :ok,
#       "10 3 *" => :error,
#       "20 2 /" => :ok
#     }
```

## 4. Run a concurrent correctness check for many inputs

Implement the `RPNCalculatorInspection.correctness_check/2` function. It should take 2 arguments, a function (the calculator), and a list of inputs for the calculator.

For every input on the list, it should start an asynchronous task that will call the calculator with the given input. Then, for every task started this way, it should await its results for 100ms.

```elixir
fast_cheating_calculator = fn input -> 14 end
inputs = ["13 1 +", "50 2 *", "1000 2 /"]
RPNCalculatorInspection.correctness_check(fast_cheating_calculator, inputs)
# => [14, 14, 14]
```

## Source

### Created by

- @angelikatyborska

### Contributed to by

- @neenjaw
