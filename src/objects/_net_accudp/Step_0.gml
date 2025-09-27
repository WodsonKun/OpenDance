/// @description Inserir descrição aqui
// Sends a empty buffer to the server, just to be able to communicate
network_send_udp(socket, ip, remote_port, send_buffer, buffer_tell(send_buffer));