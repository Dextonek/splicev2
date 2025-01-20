using Godot;
using System;

public partial class NetworkManager : Node
{
	private ENetMultiplayerPeer peer;
	private string ip = "127.0.0.1"; // Replace with your server's IP if not on localhost
	private int port = 7777;

	public override void _Ready()
	{
		ConnectToServer();
	}

	private void ConnectToServer()
	{
		peer = new ENetMultiplayerPeer();
		Error error = peer.CreateClient(ip, port);
		if (error != Error.Ok)
		{
			GD.Print($"Error creating client: {error}");
			return;
		}

		Multiplayer.MultiplayerPeer = peer;

		Multiplayer.ConnectedToServer += OnConnectionSucceeded;
		Multiplayer.ConnectionFailed += OnConnectionFailed;
		Multiplayer.ServerDisconnected += OnServerDisconnected;
	}

	private void OnConnectionSucceeded()
	{
		GD.Print("Successfully connected to server");
	}

	private void OnConnectionFailed()
	{
		GD.Print("Failed to connect to server");
	}

	private void OnServerDisconnected()
	{
		GD.Print("Disconnected from server");
	}

	public override void _Process(double delta)
	{
		// Example of sending a message to the server
		if (Input.IsActionJustPressed("ui_accept"))
		{
			SendMessageToServer("Hello from Godot!");
		}

		// Check for incoming packets
		if (Multiplayer.MultiplayerPeer.GetAvailablePacketCount() > 0)
		{
			OnPeerPacket();
		}
	}

	private void SendMessageToServer(string message)
	{
		if (Multiplayer.MultiplayerPeer.GetConnectionStatus() ==
			MultiplayerPeer.ConnectionStatus.Connected)
		{
			byte[] packet = System.Text.Encoding.UTF8.GetBytes(message);
			Multiplayer.MultiplayerPeer.PutPacket(packet);
			GD.Print($"Sent message to server: {message}");
		}
	}

	private void OnPeerPacket()
	{
		if (!Multiplayer.IsServer())
		{
			byte[] packet = Multiplayer.MultiplayerPeer.GetPacket();
			string message = System.Text.Encoding.UTF8.GetString(packet);
			GD.Print($"Received message from server: {message}");
		}
	}
}
