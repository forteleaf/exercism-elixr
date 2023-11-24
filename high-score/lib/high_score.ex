defmodule HighScore do
  @default_score 0

  def new() do
    # Please implement the new/0 function
    %{}
  end

  def add_player(scores, name, score \\ @default_score) do
    # Please implement the add_player/3 function
    Map.put(scores, name, score)
  end

  def remove_player(scores, name) do
    # Please implement the remove_player/2 function
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    # Please implement the reset_score/2 function
    #    remove_player(scores, name)
    #    add_player(scores, name)
    Map.put(scores, name, @default_score)
  end

  def update_score(scores, name, score) do
    # Please implement the update_score/3 function
    # 이 부분이 조금 난해
    Map.update(scores, name, score, &(&1 + score))
  end

  def get_players(scores) do
    # Please implement the get_players/1 function
    Map.keys(scores)
  end
end
