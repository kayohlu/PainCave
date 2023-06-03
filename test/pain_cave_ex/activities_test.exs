defmodule PainCaveEx.ActivitiesTest do
  use PainCaveEx.DataCase

  alias PainCaveEx.Activities

  describe "activities" do
    alias PainCaveEx.Activities.Activity

    import PainCaveEx.ActivitiesFixtures

    @invalid_attrs %{
      name: nil,
      timestamp: nil,
      total_distance: nil,
      total_distance_unit: nil,
      total_timer_time: nil,
      total_timer_time_unit: nil
    }

    test "list_activities/0 returns all activities" do
      activity = activity_fixture()
      assert Activities.list_activities() == [activity]
    end

    test "get_activity!/1 returns the activity with given id" do
      activity = activity_fixture()
      assert Activities.get_activity!(activity.id) == activity
    end

    test "create_activity/1 with valid data creates a activity" do
      valid_attrs = %{
        name: "some name",
        timestamp: ~N[2023-05-03 15:31:00],
        total_distance: 120.5,
        total_distance_unit: "some total_distance_unit",
        total_timer_time: 120.5,
        total_timer_time_unit: "some total_timer_time_unit"
      }

      assert {:ok, %Activity{} = activity} = Activities.create_activity(valid_attrs)
      assert activity.name == "some name"
      assert activity.timestamp == ~N[2023-05-03 15:31:00]
      assert activity.total_distance == 120.5
      assert activity.total_distance_unit == "some total_distance_unit"
      assert activity.total_timer_time == 120.5
      assert activity.total_timer_time_unit == "some total_timer_time_unit"
    end

    test "create_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activities.create_activity(@invalid_attrs)
    end

    test "update_activity/2 with valid data updates the activity" do
      activity = activity_fixture()

      update_attrs = %{
        name: "some updated name",
        timestamp: ~N[2023-05-04 15:31:00],
        total_distance: 456.7,
        total_distance_unit: "some updated total_distance_unit",
        total_timer_time: 456.7,
        total_timer_time_unit: "some updated total_timer_time_unit"
      }

      assert {:ok, %Activity{} = activity} = Activities.update_activity(activity, update_attrs)
      assert activity.name == "some updated name"
      assert activity.timestamp == ~N[2023-05-04 15:31:00]
      assert activity.total_distance == 456.7
      assert activity.total_distance_unit == "some updated total_distance_unit"
      assert activity.total_timer_time == 456.7
      assert activity.total_timer_time_unit == "some updated total_timer_time_unit"
    end

    test "update_activity/2 with invalid data returns error changeset" do
      activity = activity_fixture()
      assert {:error, %Ecto.Changeset{}} = Activities.update_activity(activity, @invalid_attrs)
      assert activity == Activities.get_activity!(activity.id)
    end

    test "delete_activity/1 deletes the activity" do
      activity = activity_fixture()
      assert {:ok, %Activity{}} = Activities.delete_activity(activity)
      assert_raise Ecto.NoResultsError, fn -> Activities.get_activity!(activity.id) end
    end

    test "change_activity/1 returns a activity changeset" do
      activity = activity_fixture()
      assert %Ecto.Changeset{} = Activities.change_activity(activity)
    end
  end
end
