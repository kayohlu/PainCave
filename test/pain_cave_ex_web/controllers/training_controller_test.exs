defmodule PainCaveExWeb.TrainingControllerTest do
  use PainCaveExWeb.ConnCase

  import PainCaveEx.TrainingsFixtures

  @create_attrs %{test: "some test"}
  @update_attrs %{test: "some updated test"}
  @invalid_attrs %{test: nil}

  describe "index" do
    test "lists all trainings", %{conn: conn} do
      conn = get(conn, ~p"/trainings")
      assert html_response(conn, 200) =~ "Listing Trainings"
    end
  end

  describe "new training" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/trainings/new")
      assert html_response(conn, 200) =~ "New Training"
    end
  end

  describe "create training" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/trainings", training: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/trainings/#{id}"

      conn = get(conn, ~p"/trainings/#{id}")
      assert html_response(conn, 200) =~ "Training #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/trainings", training: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Training"
    end
  end

  describe "edit training" do
    setup [:create_training]

    test "renders form for editing chosen training", %{conn: conn, training: training} do
      conn = get(conn, ~p"/trainings/#{training}/edit")
      assert html_response(conn, 200) =~ "Edit Training"
    end
  end

  describe "update training" do
    setup [:create_training]

    test "redirects when data is valid", %{conn: conn, training: training} do
      conn = put(conn, ~p"/trainings/#{training}", training: @update_attrs)
      assert redirected_to(conn) == ~p"/trainings/#{training}"

      conn = get(conn, ~p"/trainings/#{training}")
      assert html_response(conn, 200) =~ "some updated test"
    end

    test "renders errors when data is invalid", %{conn: conn, training: training} do
      conn = put(conn, ~p"/trainings/#{training}", training: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Training"
    end
  end

  describe "delete training" do
    setup [:create_training]

    test "deletes chosen training", %{conn: conn, training: training} do
      conn = delete(conn, ~p"/trainings/#{training}")
      assert redirected_to(conn) == ~p"/trainings"

      assert_error_sent 404, fn ->
        get(conn, ~p"/trainings/#{training}")
      end
    end
  end

  defp create_training(_) do
    training = training_fixture()
    %{training: training}
  end
end
