# RPN Calculator

Welcome to RPN Calculator on Exercism's Elixir Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## Errors

Errors happen. In Elixir, while people often say to "let it crash", there are times when we need to rescue the function call to a known good state to fulfill a software contract. In some languages, errors are used as a method of control flow, but in Elixir, this pattern is discouraged. We can often recognize functions that may raise an error just by their name: functions that raise errors are to have `!` at the end of their name. This is in comparison with functions that return `{:ok, value}` or `:error`. Look at these library examples:

```elixir
Map.fetch(%{a: 1}, :b)
# => :error
Map.fetch!(%{a: 1}, :b)
# => raises KeyError
```

## Try/Rescue

Elixir provides a construct for rescuing from errors using `try .. rescue`

```elixir
try do                             #1
  raise RuntimeError, "error"      #2
rescue
  e in RuntimeError -> :error      #3
end
```

Let's examine this construct:

- **Line 1**, the block is declared with `try`.
- **Line 2**, the function call which may error is placed here, in this case we are calling `raise/2`.
- **Line 3**, in the `rescue` section, we pattern match on the _Module_ name of the error raised
  - on the left side of `->`:
    - `e` is matched to the error struct.
    - `in` is a keyword.
    - `RuntimeError` is the error that we want to rescue.
      - If we wanted to rescue from all errors, we could use `_` instead of the module name or omit the `in` keyword entirely.
  - on the right side:
    - the instructions to be executed if the error matches.

### Error structs

Errors (sometimes also called "exceptions") that you rescue this way are structs.
Rescuing errors in Elixir is done very rarely.
Usually the rescued error is logged or sent to an external monitoring service, and then reraised.
This means we usually don't care about the internal structure of the specific error struct.

In the [Exceptions concept][exercism-exceptions] you will learn more about error structs, including how to define your own custom error.

[exercism-exceptions]: https://exercism.org/tracks/elixir/concepts/exceptions

## Instructions

While working at _Instruments of Texas_, you are tasked to work on an experimental Reverse Polish Notation [RPN] calculator written in Elixir. Your team is having a problem with some operations raising errors and crashing the process. You have been tasked to write a function which wraps the operation function so that the errors can be handled more elegantly with idiomatic Elixir code.
텍사스 인스트루먼트에서 근무하는 동안, 여러분은 Elixir로 작성된 실험적인 역 폴란드어 표기법[RPN] 계산기 작업을 맡게 되었습니다. 팀에서 일부 연산에서 오류가 발생하고 프로세스가 중단되는 문제를 겪고 있습니다. 여러분은 관용적인 Elixir 코드로 오류를 더 우아하게 처리할 수 있도록 연산 함수를 감싸는 함수를 작성하라는 과제를 받았습니다.

## 1. Warn the team

Implement the function `calculate!/2` to call the operation function with the stack as the only argument. The operation function is defined elsewhere, but you know that it can either complete successfully or raise an error.
계산!/2 함수를 구현하여 스택을 유일한 인수로 연산 함수를 호출합니다. 연산 함수는 다른 곳에 정의되어 있지만 성공적으로 완료되거나 오류를 발생시킬 수 있다는 것을 알고 있습니다.

```elixir
stack = []
operation = fn _ -> :ok end
RPNCalculator.calculate!(stack, operation)
# => :ok

stack = []
operation = fn _ -> raise ArgumentError, "An error occurred" end
RPNCalculator.calculate!(stack, operation)
# => ** (ArgumentError) An error occurred
```

> Function names that end in `!` are a warning to programmers that this function may raise an error
> !로 끝나는 함수 이름 이 함수는 오류를 일으킬 수 있다는 것을 프로그래머에게 경고하는 것입니다.

## 2. Wrap the error

When doing more research you notice that many functions use atoms and tuples to indicate their success/failure. Implement `calculate/2` using this strategy.
더 많은 연구를 해보면 많은 함수가 성공/실패를 나타내기 위해 원자와 튜플을 사용한다는 것을 알 수 있습니다. 이 전략을 사용하여 `calculate/2`를 구현합니다.

```elixir
stack = []
operation = fn _ -> "operation completed" end
RPNCalculator.calculate(stack, operation)
# => {:ok, "operation completed"}

stack = []
operation = fn _ -> raise ArgumentError, "An error occurred" end
RPNCalculator.calculate(stack, operation)
# => :error
```

## 3. Pass on the message

Some of the errors contain important information that your coworkers need to have to ensure the correct operation of the system. Implement `calculate_verbose/2` to pass on the error message. The error is a struct that has a `:message` field.
일부 오류에는 동료가 시스템의 올바른 작동을 보장하는 데 필요한 중요한 정보가 포함되어 있습니다. 오류 메시지를 전달하려면calcul_verbose/2를 구현하십시오. 오류는 :message 필드가 있는 구조체입니다.

```elixir
stack = []
operation = fn _ -> "operation completed" end
RPNCalculator.calculate_verbose(stack, operation)
# => {:ok, "operation completed"}

stack = []
operation = fn _ -> raise ArgumentError, "An error occurred" end
RPNCalculator.calculate_verbose(stack, operation)
# => {:error, "An error occurred"}
```

## Source

### Created by

- @neenjaw

### Contributed to by

- @angelikatyborska
- @cjmaxik
