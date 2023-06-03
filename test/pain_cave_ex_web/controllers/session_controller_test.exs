defmodule PainCaveExWeb.SessionControllerTest do
  use PainCaveExWeb.ConnCase

  import PainCaveEx.SessionsFixtures

  @create_attrs %{
    pool_length: 120.5,
    avg_power: 120.5,
    total_descent: 120.5,
    avg_heart_rate_unit: "some avg_heart_rate_unit",
    total_elapsed_time: 120.5,
    stroke_count: 120.5,
    total_distance: 120.5,
    avg_stroke_distance_unit: "some avg_stroke_distance_unit",
    avg_heart_rate: 120.5,
    avg_stroke_count_unit: "some avg_stroke_count_unit",
    max_heart_rate_unit: "some max_heart_rate_unit",
    total_elapsed_time_unit: "some total_elapsed_time_unit",
    max_heart_rate: 120.5,
    max_speed_unit: "some max_speed_unit",
    avg_stroke_count: 120.5,
    total_timer_time_unit: "some total_timer_time_unit",
    min_heart_rate_unit: "some min_heart_rate_unit",
    max_power: 120.5,
    total_timer_time: 120.5,
    total_descent_unit: "some total_descent_unit",
    avg_speed: 120.5,
    total_ascent: 120.5,
    avg_power_unit: "some avg_power_unit",
    pool_length_unit: "some pool_length_unit",
    sub_sport: "some sub_sport",
    total_ascent_unit: "some total_ascent_unit",
    total_moving_time: 120.5,
    timestamp: ~N[2023-05-03 15:44:00],
    total_moving_time_unit: "some total_moving_time_unit",
    max_power_unit: "some max_power_unit",
    avg_speed_unit: "some avg_speed_unit",
    max_speed: 120.5,
    sport: "some sport",
    stroke_count_unit: "some stroke_count_unit",
    total_distance_unit: "some total_distance_unit",
    threshold_power_unit: "some threshold_power_unit",
    avg_stroke_distance: 120.5,
    threshold_power: 120.5,
    min_heart_rate: 120.5
  }
  @update_attrs %{
    pool_length: 456.7,
    avg_power: 456.7,
    total_descent: 456.7,
    avg_heart_rate_unit: "some updated avg_heart_rate_unit",
    total_elapsed_time: 456.7,
    stroke_count: 456.7,
    total_distance: 456.7,
    avg_stroke_distance_unit: "some updated avg_stroke_distance_unit",
    avg_heart_rate: 456.7,
    avg_stroke_count_unit: "some updated avg_stroke_count_unit",
    max_heart_rate_unit: "some updated max_heart_rate_unit",
    total_elapsed_time_unit: "some updated total_elapsed_time_unit",
    max_heart_rate: 456.7,
    max_speed_unit: "some updated max_speed_unit",
    avg_stroke_count: 456.7,
    total_timer_time_unit: "some updated total_timer_time_unit",
    min_heart_rate_unit: "some updated min_heart_rate_unit",
    max_power: 456.7,
    total_timer_time: 456.7,
    total_descent_unit: "some updated total_descent_unit",
    avg_speed: 456.7,
    total_ascent: 456.7,
    avg_power_unit: "some updated avg_power_unit",
    pool_length_unit: "some updated pool_length_unit",
    sub_sport: "some updated sub_sport",
    total_ascent_unit: "some updated total_ascent_unit",
    total_moving_time: 456.7,
    timestamp: ~N[2023-05-04 15:44:00],
    total_moving_time_unit: "some updated total_moving_time_unit",
    max_power_unit: "some updated max_power_unit",
    avg_speed_unit: "some updated avg_speed_unit",
    max_speed: 456.7,
    sport: "some updated sport",
    stroke_count_unit: "some updated stroke_count_unit",
    total_distance_unit: "some updated total_distance_unit",
    threshold_power_unit: "some updated threshold_power_unit",
    avg_stroke_distance: 456.7,
    threshold_power: 456.7,
    min_heart_rate: 456.7
  }
  @invalid_attrs %{
    pool_length: nil,
    avg_power: nil,
    total_descent: nil,
    avg_heart_rate_unit: nil,
    total_elapsed_time: nil,
    stroke_count: nil,
    total_distance: nil,
    avg_stroke_distance_unit: nil,
    avg_heart_rate: nil,
    avg_stroke_count_unit: nil,
    max_heart_rate_unit: nil,
    total_elapsed_time_unit: nil,
    max_heart_rate: nil,
    max_speed_unit: nil,
    avg_stroke_count: nil,
    total_timer_time_unit: nil,
    min_heart_rate_unit: nil,
    max_power: nil,
    total_timer_time: nil,
    total_descent_unit: nil,
    avg_speed: nil,
    total_ascent: nil,
    avg_power_unit: nil,
    pool_length_unit: nil,
    sub_sport: nil,
    total_ascent_unit: nil,
    total_moving_time: nil,
    timestamp: nil,
    total_moving_time_unit: nil,
    max_power_unit: nil,
    avg_speed_unit: nil,
    max_speed: nil,
    sport: nil,
    stroke_count_unit: nil,
    total_distance_unit: nil,
    threshold_power_unit: nil,
    avg_stroke_distance: nil,
    threshold_power: nil,
    min_heart_rate: nil
  }

  describe "index" do
    test "lists all sessions", %{conn: conn} do
      conn = get(conn, ~p"/sessions")
      assert html_response(conn, 200) =~ "Listing Sessions"
    end
  end

  describe "new session" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/sessions/new")
      assert html_response(conn, 200) =~ "New Session"
    end
  end

  describe "create session" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/sessions", session: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/sessions/#{id}"

      conn = get(conn, ~p"/sessions/#{id}")
      assert html_response(conn, 200) =~ "Session #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/sessions", session: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Session"
    end
  end

  describe "edit session" do
    setup [:create_session]

    test "renders form for editing chosen session", %{conn: conn, session: session} do
      conn = get(conn, ~p"/sessions/#{session}/edit")
      assert html_response(conn, 200) =~ "Edit Session"
    end
  end

  describe "update session" do
    setup [:create_session]

    test "redirects when data is valid", %{conn: conn, session: session} do
      conn = put(conn, ~p"/sessions/#{session}", session: @update_attrs)
      assert redirected_to(conn) == ~p"/sessions/#{session}"

      conn = get(conn, ~p"/sessions/#{session}")
      assert html_response(conn, 200) =~ "some updated avg_heart_rate_unit"
    end

    test "renders errors when data is invalid", %{conn: conn, session: session} do
      conn = put(conn, ~p"/sessions/#{session}", session: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Session"
    end
  end

  describe "delete session" do
    setup [:create_session]

    test "deletes chosen session", %{conn: conn, session: session} do
      conn = delete(conn, ~p"/sessions/#{session}")
      assert redirected_to(conn) == ~p"/sessions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/sessions/#{session}")
      end
    end
  end

  defp create_session(_) do
    session = session_fixture()
    %{session: session}
  end
end
