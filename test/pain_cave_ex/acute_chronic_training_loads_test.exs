defmodule PainCaveEx.AcuteChronicTrainingLoadsTest do
  use PainCaveEx.DataCase

  alias PainCaveEx.AcuteChronicTrainingLoads

  describe "acute_chronic_training_loads" do
    alias PainCaveEx.AcuteChronicTrainingLoads.AcuteChronicTrainingLoad

    import PainCaveEx.AcuteChronicTrainingLoadsFixtures

    @invalid_attrs %{
      acute_load: nil,
      acute_range: nil,
      chronic_load: nil,
      chronic_range: nil,
      ratio: nil
    }

    test "list_acute_chronic_training_loads/0 returns all acute_chronic_training_loads" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      assert AcuteChronicTrainingLoads.list_acute_chronic_training_loads() == [
               acute_chronic_training_load
             ]
    end

    test "get_acute_chronic_training_load!/1 returns the acute_chronic_training_load with given id" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      assert AcuteChronicTrainingLoads.get_acute_chronic_training_load!(
               acute_chronic_training_load.id
             ) == acute_chronic_training_load
    end

    test "create_acute_chronic_training_load/1 with valid data creates a acute_chronic_training_load" do
      valid_attrs = %{
        acute_load: 120.5,
        acute_range: 42,
        chronic_load: 120.5,
        chronic_range: 42,
        ratio: 120.5
      }

      assert {:ok, %AcuteChronicTrainingLoad{} = acute_chronic_training_load} =
               AcuteChronicTrainingLoads.create_acute_chronic_training_load(valid_attrs)

      assert acute_chronic_training_load.acute_load == 120.5
      assert acute_chronic_training_load.acute_range == 42
      assert acute_chronic_training_load.chronic_load == 120.5
      assert acute_chronic_training_load.chronic_range == 42
      assert acute_chronic_training_load.ratio == 120.5
    end

    test "create_acute_chronic_training_load/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               AcuteChronicTrainingLoads.create_acute_chronic_training_load(@invalid_attrs)
    end

    test "update_acute_chronic_training_load/2 with valid data updates the acute_chronic_training_load" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      update_attrs = %{
        acute_load: 456.7,
        acute_range: 43,
        chronic_load: 456.7,
        chronic_range: 43,
        ratio: 456.7
      }

      assert {:ok, %AcuteChronicTrainingLoad{} = acute_chronic_training_load} =
               AcuteChronicTrainingLoads.update_acute_chronic_training_load(
                 acute_chronic_training_load,
                 update_attrs
               )

      assert acute_chronic_training_load.acute_load == 456.7
      assert acute_chronic_training_load.acute_range == 43
      assert acute_chronic_training_load.chronic_load == 456.7
      assert acute_chronic_training_load.chronic_range == 43
      assert acute_chronic_training_load.ratio == 456.7
    end

    test "update_acute_chronic_training_load/2 with invalid data returns error changeset" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      assert {:error, %Ecto.Changeset{}} =
               AcuteChronicTrainingLoads.update_acute_chronic_training_load(
                 acute_chronic_training_load,
                 @invalid_attrs
               )

      assert acute_chronic_training_load ==
               AcuteChronicTrainingLoads.get_acute_chronic_training_load!(
                 acute_chronic_training_load.id
               )
    end

    test "delete_acute_chronic_training_load/1 deletes the acute_chronic_training_load" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      assert {:ok, %AcuteChronicTrainingLoad{}} =
               AcuteChronicTrainingLoads.delete_acute_chronic_training_load(
                 acute_chronic_training_load
               )

      assert_raise Ecto.NoResultsError, fn ->
        AcuteChronicTrainingLoads.get_acute_chronic_training_load!(acute_chronic_training_load.id)
      end
    end

    test "change_acute_chronic_training_load/1 returns a acute_chronic_training_load changeset" do
      acute_chronic_training_load = acute_chronic_training_load_fixture()

      assert %Ecto.Changeset{} =
               AcuteChronicTrainingLoads.change_acute_chronic_training_load(
                 acute_chronic_training_load
               )
    end
  end
end
