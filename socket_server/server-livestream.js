const io = require('socket.io')(3000, {
    cors: { origin: '*' }
  });
  
  io.on('connection', (socket) => {
    console.log('🎥 Livestream client connected');
  
    // Comment real-time (giữ nguyên)
    socket.on('join_livestream', (username) => {
      socket.username = username;
      console.log(`${username} joined livestream`);
    });
  
    socket.on('new_comment', (data) => {
      const comment = {
        username: data.username || socket.username || 'Anonymous',
        content: data.content,
        time: new Date().toISOString()
      };
      console.log('[COMMENT]', comment);
      io.emit('new_comment', comment);
    });
  
    // 👉 WebRTC signaling
    socket.on('offer', (data) => {
      console.log('[SIGNAL] Offer received');
      socket.broadcast.emit('offer', data); // gửi đến tất cả client khác
    });
  
    socket.on('answer', (data) => {
      console.log('[SIGNAL] Answer received');
      socket.broadcast.emit('answer', data);
    });
  
    socket.on('ice-candidate', (data) => {
      console.log('[SIGNAL] ICE candidate');
      socket.broadcast.emit('ice-candidate', data);
    });
  });
  