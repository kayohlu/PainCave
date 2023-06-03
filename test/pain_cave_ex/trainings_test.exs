defmodule PainCaveEx.TrainingsTest do
  use PainCaveEx.DataCase

  alias PainCaveEx.Trainings

  describe "trainings" do
    alias PainCaveEx.Trainings.Training

    import PainCaveEx.TrainingsFixtures

    @invalid_attrs %{test: nil}

    test "list_trainings/0 returns all trainings" do
      training = training_fixture()
      assert Trainings.list_trainings() == [training]
    end

    test "get_training!/1 returns the training with given id" do
      training = training_fixture()
      assert Trainings.get_training!(training.id) == training
    end

    test "create_training/1 with valid data creates a training" do
      valid_attrs = %{test: "some test"}

      assert {:ok, %Training{} = training} = Trainings.create_training(valid_attrs)
      assert training.test == "some test"
    end

    test "create_training/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trainings.create_training(@invalid_attrs)
    end

    test "update_training/2 with valid data updates the training" do
      training = training_fixture()
      update_attrs = %{test: "some updated test"}

      assert {:ok, %Training{} = training} = Trainings.update_training(training, update_attrs)
      assert training.test == "some updated test"
    end

    test "update_training/2 with invalid data returns error changeset" do
      training = training_fixture()
      assert {:error, %Ecto.Changeset{}} = Trainings.update_training(training, @invalid_attrs)
      assert training == Trainings.get_training!(training.id)
    end

    test "delete_training/1 deletes the training" do
      training = training_fixture()
      assert {:ok, %Training{}} = Trainings.delete_training(training)
      assert_raise Ecto.NoResultsError, fn -> Trainings.get_training!(training.id) end
    end

    test "change_training/1 returns a training changeset" do
      training = training_fixture()
      assert %Ecto.Changeset{} = Trainings.change_training(training)
    end
  end
end
