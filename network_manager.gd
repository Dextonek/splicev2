extends Node

var peer = ENetMultiplayerPeer.new()
var ip = "127.0.0.1"  # Replace with your server's IP if not on localhost
var port = 7777

func _ready():
	connect_to_server()
	multiplayer.peer_packet.connect(_on_peer_packet)

func connect_to_server():
	var error = peer.create_client(ip, port)
	if error != OK:
		print("Error creating client: ", error)
		return
	
	multiplayer.multiplayer_peer = peer
	
	multiplayer.connected_to_server.connect(_on_connection_succeeded)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

func _on_connection_succeeded():
	print("Successfully connected to server")

func _on_connection_failed():
	print("Failed to connect to server")

func _on_server_disconnected():
	print("Disconnected from server")

func _process(delta):
	# Example of sending a message to the server
	if Input.is_action_just_pressed("ui_accept"):
		send_message_to_server("Hello from Godot!")

func send_message_to_server(message: String):
	if multiplayer.multiplayer_peer.get_connection_status() == MultiplayerPeer.CONNECTION_CONNECTED:
		var packet = message.to_utf8_buffer()
		multiplayer.multiplayer_peer.put_packet(packet)
		print("Sent message to server: ", message)

func _on_peer_packet():
	if not multiplayer.is_server():
		var packet = multiplayer.multiplayer_peer.get_packet()
		var message = packet.get_string_from_utf8()
		print("Received message from server: ", message)
