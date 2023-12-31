# New Passport

Welcome to New Passport on Exercism's Elixir Track.
If you need help running the tests or submitting your code, check out `HELP.md`.
If you get stuck on the exercise, check out `HINTS.md`, but try and solve it without using those first :)

## Introduction

## With

The [special form with][with] provides a way to focus on the "happy path" of a series of potentially failing steps and deal with the failures later.

```elixir
with {:ok, id} <- get_id(username),
     {:ok, avatar} <- fetch_avatar(id),
     {:ok, image_type} <- check_valid_image_type(avatar) do
  {:ok, image_type, avatar}
else
  :not_found ->
    {:error, "invalid username"}

  {:error, "not an image"} ->
    {:error, "avatar associated to #{username} is not an image"}

  err ->
    err
end
```

At each step, if a clause matches, the chain will continue until the `do` block is executed. If one match fails, the chain stops and the non-matching clause is returned. You have the option of using an `else` block to catch failed matches and modify the return value.

[with]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#with/1

## Instructions

Your passport is about to expire, so you need to drop by the city office to renew it. You know from previous experience that your city office is not necessarily the easiest to deal with, so you decide to do your best to always "focus on the happy path".
여권 유효기간이 곧 만료되므로 시청에 들러 갱신해야 합니다. 당신은 이전 경험을 통해 귀하의 시청이 반드시 처리하기 가장 쉬운 것은 아니라는 것을 알고 있으므로 항상 "happy path"하기 위해 최선을 다하기로 결정했습니다.

You print out the form you need to get your new passport, fill it out, jump into your car, drive around the block, park and head to the office.
새 여권을 받는 데 필요한 양식을 인쇄하고, 작성하고, 차에 올라타고, 한 블록을 운전하고, 주차한 후 사무실로 향합니다.

All the following tasks will require implementing and extending `get_new_passport/3`.
다음 모든 작업에는 get_new_passport/3을 구현하고 확장해야 합니다.

## 1. Get into the building

It turns out that the building is only open in the afternoon, and not at the same time everyday.

Call the function `enter_building/1` with the current time (given to you as first argument of `get_new_passport/3`). If the building is open, the function will return a tuple with `:ok` and a timestamp that you will need later, otherwise a tuple with `:error` and a message. For now, the happy path can return the `:ok` tuple.

If you get an `:error` tuple, use the `else` block to return it.

알고 보니 건물은 오후에만 문을 열며 매일 같은 시간에는 문을 열지 않습니다.

현재 시간(get_new_passport/3의 첫 번째 인수로 제공됨)으로 enter_building/1 함수를 호출합니다. 건물이 열려 있으면 함수는 나중에 필요할 타임스탬프와 :ok가 포함된 튜플을 반환하고, 그렇지 않으면 :error와 메시지가 포함된 튜플을 반환합니다. 현재로서는 Happy 경로가 :ok 튜플을 반환할 수 있습니다.

:error 튜플을 얻으면 else 블록을 사용하여 이를 반.환하세요

## 2. Go to the information desk and find which counter you should go to

The information desk is notorious for taking long coffee breaks. If you are lucky enough to find someone there, they will give you an instruction manual which will explain which counter you need to go to depending on your birth date.

Call the function `find_counter_information/1` with the current time. You will get either a tuple with `:ok` and a manual, represented by an anonymous function, or a tuple with `:coffee_break` and more instructions. In your happy path where you receive the manual, apply it to your birthday (second argument of `get_new_passport/3`). It will return the number of the counter where you need to go. Return an `:ok` tuple with that counter number.

If you get a `:coffee_break` message, return a tuple with `:retry` and a `NaiveDateTime` pointing to 15 minutes after the current time. As before, if you get an `:error` tuple, return it.

안내 데스크는 커피를 마시는 데 시간이 오래 걸리는 것으로 악명이 높습니다. 운이 좋으면 안내 직원이 생년월일에 따라 어느 카운터로 가야 하는지 설명해 주는 안내서를 받을 수 있습니다.

현재 시간과 함께 `find_counter_information/1` 함수를 호출하세요. 익명 함수로 표현되는 `:ok`와 매뉴얼이 포함된 튜플 또는 `:coffee_break`와 더 많은 지침이 포함된 튜플이 반환됩니다. 매뉴얼을 받은 행복 경로에서 생일에 적용합니다(`get_new_passport/3`의 두 번째 인수). 그러면 가야 할 카운터 번호가 반환됩니다. 해당 카운터 번호가 포함된 `:OK` 튜플을 반환합니다.

coffee_break` 메시지를 받으면 `:retry`와 현재 시간으로부터 15분을 가리키는 `NaiveDateTime`이 포함된 튜플을 반환합니다. 이전과 마찬가지로 `:error` 튜플을 받으면 반환합니다.

## 3. Go to the counter and get your form stamped

For some reason, different counters require forms of different colors. Of course, you printed the first one you found on the website, so you focus on your happy path and hope for the best.

Call the function `stamp_form/3` with the timestamp you received at the entrance, the counter and the form you brought (last argument of `get_new_passport/3`). You will get either a tuple with `:ok` and a checksum that will be used to verify your passport number or a tuple with `:error` and a message. Have your happy path return an `:ok` tuple with the checksum. If you get an `:error` tuple, return it.
어떤 이유에서인지 카운터마다 다른 색상의 양식이 필요합니다. 물론 웹사이트에서 가장 먼저 찾은 것을 인쇄했으니 행복한 길에 집중하고 최선을 다하길 바랍니다.

입구에서 받은 타임스탬프, 카운터, 가져온 양식(`get_new_passport/3`의 마지막 인수)과 함께 `stamp_form/3` 함수를 호출합니다. 여권 번호를 확인하는 데 사용되는 `:ok`와 체크섬이 포함된 튜플 또는 `:error`와 메시지가 포함된 튜플이 반환됩니다. 행복 경로가 체크섬과 함께 `:ok` 튜플을 반환하도록 합니다. 오류` 튜플을 받으면 반환합니다.

## 4. Receive your new passport

Finally, you have all the documents you need.

Call `get_new_passport_number/3` with the timestamp, the counter and the checksum you received earlier. You will receive a string with your final passport number, all that is left to do is to return that string in a tuple with `:ok` and go home.
마지막으로 필요한 모든 서류가 준비되었습니다.

타임스탬프, 카운터, 앞서 받은 체크섬과 함께 `get_new_passport_number/3`을 호출합니다. 최종 여권 번호가 포함된 문자열을 받게 되며, 이제 남은 작업은 해당 문자열을 `:OK`와 함께 튜플로 반환하고 집으로 돌아가는 것입니다.

## Source

### Created by

- @jiegillet

### Contributed to by

- @angelikatyborska
