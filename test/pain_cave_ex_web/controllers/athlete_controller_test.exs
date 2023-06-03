defmodule PainCaveExWeb.AthleteControllerTest do
  use PainCaveExWeb.ConnCase

  import PainCaveEx.AthletesFixtures

  @create_attrs %{email: "some email", name: "some name"}
  @update_attrs %{email: "some updated email", name: "some updated name"}
  @invalid_attrs %{email: nil, name: nil}

  describe "index" do
    test "lists all athletes", %{conn: conn} do
      conn = get(conn, ~p"/athletes")
      assert html_response(conn, 200) =~ "Listing Athletes"
    end
  end

  describe "new athlete" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/athletes/new")
      assert html_response(conn, 200) =~ "New Athlete"
    end
  end

  describe "create athlete" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/athletes", athlete: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/athletes/#{id}"

      conn = get(conn, ~p"/athletes/#{id}")
      assert html_response(conn, 200) =~ "Athlete #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/athletes", athlete: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Athlete"
    end
  end

  describe "edit athlete" do
    setup [:create_athlete]

    test "renders form for editing chosen athlete", %{conn: conn, athlete: athlete} do
      conn = get(conn, ~p"/athletes/#{athlete}/edit")
      assert html_response(conn, 200) =~ "Edit Athlete"
    end
  end

  describe "update athlete" do
    setup [:create_athlete]

    test "redirects when data is valid", %{conn: conn, athlete: athlete} do
      conn = put(conn, ~p"/athletes/#{athlete}", athlete: @update_attrs)
      assert redirected_to(conn) == ~p"/athletes/#{athlete}"

      conn = get(conn, ~p"/athletes/#{athlete}")
      assert html_response(conn, 200) =~ "some updated email"
    end

    test "renders errors when data is invalid", %{conn: conn, athlete: athlete} do
      conn = put(conn, ~p"/athletes/#{athlete}", athlete: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Athlete"
    end
  end

  describe "delete athlete" do
    setup [:create_athlete]

    test "deletes chosen athlete", %{conn: conn, athlete: athlete} do
      conn = delete(conn, ~p"/athletes/#{athlete}")
      assert redirected_to(conn) == ~p"/athletes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/athletes/#{athlete}")
      end
    end
  end

  defp create_athlete(_) do
    athlete = athlete_fixture()
    %{athlete: athlete}
  end
end
