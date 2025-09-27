/// @description Inserir descrição aqui
// Creates a socket, and sets a server 
socket = network_create_socket(network_socket_udp); // Doesn't need a port, as the client kinda doesn't care
ip = "192.168.0.255"; // Sets the server IP
remote_port = 26760; // Sets the server port

// Creates a buffer to store packet data
send_buffer = buffer_create(1024, buffer_fixed, 1);

// Placeholder 
remotex = 0;
remotey = 0;
remotez = 0;

// Placeholder buffer (idk)
buffer_seek(send_buffer, buffer_seek_start,0);
buffer_write(send_buffer, buffer_u8, 1); //id. Use different ones for different msg types
buffer_write(send_buffer, buffer_f32, 0);
buffer_write(send_buffer, buffer_f32, 0);
buffer_write(send_buffer, buffer_f32, 0);