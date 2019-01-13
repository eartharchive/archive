defmodule Archive.ArchivesTest do
  use Archive.DataCase

  alias Archive.Archives

  describe "requests" do
    alias Archive.Archives.Request

    @valid_attrs %{content: "some content", status: "some status", title: "some title"}
    @update_attrs %{content: "some updated content", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{content: nil, status: nil, title: nil}

    def request_fixture(attrs \\ %{}) do
      {:ok, request} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Archives.create_request()

      request
    end

    test "list_requests/0 returns all requests" do
      request = request_fixture()
      assert Archives.list_requests() == [request]
    end

    test "get_request!/1 returns the request with given id" do
      request = request_fixture()
      assert Archives.get_request!(request.id) == request
    end

    test "create_request/1 with valid data creates a request" do
      assert {:ok, %Request{} = request} = Archives.create_request(@valid_attrs)
      assert request.content == "some content"
      assert request.status == "some status"
      assert request.title == "some title"
    end

    test "create_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archives.create_request(@invalid_attrs)
    end

    test "update_request/2 with valid data updates the request" do
      request = request_fixture()
      assert {:ok, %Request{} = request} = Archives.update_request(request, @update_attrs)
      assert request.content == "some updated content"
      assert request.status == "some updated status"
      assert request.title == "some updated title"
    end

    test "update_request/2 with invalid data returns error changeset" do
      request = request_fixture()
      assert {:error, %Ecto.Changeset{}} = Archives.update_request(request, @invalid_attrs)
      assert request == Archives.get_request!(request.id)
    end

    test "delete_request/1 deletes the request" do
      request = request_fixture()
      assert {:ok, %Request{}} = Archives.delete_request(request)
      assert_raise Ecto.NoResultsError, fn -> Archives.get_request!(request.id) end
    end

    test "change_request/1 returns a request changeset" do
      request = request_fixture()
      assert %Ecto.Changeset{} = Archives.change_request(request)
    end
  end

  describe "partners" do
    alias Archive.Archives.Partner

    @valid_attrs %{role: "some role"}
    @update_attrs %{role: "some updated role"}
    @invalid_attrs %{role: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Archives.create_partner()

      partner
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Archives.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Archives.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Archives.create_partner(@valid_attrs)
      assert partner.role == "some role"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Archives.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{} = partner} = Archives.update_partner(partner, @update_attrs)
      assert partner.role == "some updated role"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Archives.update_partner(partner, @invalid_attrs)
      assert partner == Archives.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Archives.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Archives.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Archives.change_partner(partner)
    end
  end
end
