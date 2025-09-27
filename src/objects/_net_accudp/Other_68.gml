/// @description Inserir descrição aqui
// Checks the network for data and processes it
var buffer = async_load[? "buffer"];
buffer_seek(buffer, buffer_seek_start, 0);
process_packet(buffer);