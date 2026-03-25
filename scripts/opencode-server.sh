#!/bin/bash

# opencode 服务器管理脚本
# 用于启动、停止和检查 opencode 服务器状态

PORT=4096
HOST="127.0.0.1"
PIDFILE="$HOME/.local/state/opencode/server.pid"

case "$1" in
  start)
    echo "启动 opencode 服务器..."
    if [ -f "$PIDFILE" ] && kill -0 `cat "$PIDFILE"` 2>/dev/null; then
      echo "opencode 服务器已经在运行 (PID: $(cat $PIDFILE))"
    else
      nohup opencode serve --port $PORT --hostname $HOST > /dev/null 2>&1 &
      echo $! > "$PIDFILE"
      echo "opencode 服务器已启动在 http://$HOST:$PORT (PID: $!)"
    fi
    ;;
  
  stop)
    echo "停止 opencode 服务器..."
    if [ -f "$PIDFILE" ] && kill -0 `cat "$PIDFILE"` 2>/dev/null; then
      kill `cat "$PIDFILE"`
      rm -f "$PIDFILE"
      echo "opencode 服务器已停止"
    else
      echo "opencode 服务器未运行"
    fi
    ;;
  
  status)
    if [ -f "$PIDFILE" ] && kill -0 `cat "$PIDFILE"` 2>/dev/null; then
      echo "opencode 服务器正在运行 (PID: $(cat $PIDFILE))"
      echo "服务器地址: http://$HOST:$PORT"
      
      # 测试服务器是否响应
      if command -v curl > /dev/null; then
        if curl -s -f "http://$HOST:$PORT/health" > /dev/null; then
          echo "服务器状态: 健康"
        else
          echo "服务器状态: 无响应"
        fi
      fi
    else
      echo "opencode 服务器未运行"
    fi
    ;;
  
  restart)
    $0 stop
    sleep 2
    $0 start
    ;;
  
  *)
    echo "用法: $0 {start|stop|status|restart}"
    echo ""
    echo "命令说明:"
    echo "  start   - 启动 opencode 服务器"
    echo "  stop    - 停止 opencode 服务器"
    echo "  status  - 检查服务器状态"
    echo "  restart - 重启服务器"
    exit 1
    ;;
esac