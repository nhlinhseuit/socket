const io = require('socket.io')(3000, {
    cors: {
        origin: '*'
    }
});

console.log('🚀 Socket server is running on port 3000');

io.on('connection', (socket) => {
    console.log('✅ New client connected');

    socket.on('join', (username) => {
        socket.username = username;
        console.log(`${username} joined`);
    });

    socket.on('message', (data) => {
        const messageData = {
            from: socket.username || 'Anonymous',
            content: data.content,
            time: new Date().toISOString()  // ← gửi về thời gian
        };
        io.emit('message', messageData);
    });


    socket.on('disconnect', () => {
        console.log(`${socket.username || 'A user'} disconnected`);
    });
});
