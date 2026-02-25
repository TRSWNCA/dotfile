#!/bin/bash

# 持续获取网络流量信息的脚本
# 从 http://127.0.0.1:9090/traffic 获取上行和下行流量

# 设置超时时间
TIMEOUT=10

# 持续监听流量数据
curl -s --max-time $TIMEOUT --no-buffer http://127.0.0.1:9090/traffic 2>/dev/null | while read -r DATA; do
    # 检查是否获取到数据
    if [ -n "$DATA" ] && [ "$DATA" != "null" ]; then
        # 解析 JSON 数据获取 up 和 down 值
        UP=$(echo "$DATA" | jq -r '.up // 0' 2>/dev/null)
        DOWN=$(echo "$DATA" | jq -r '.down // 0' 2>/dev/null)
        
        # 检查数值是否有效
        if [[ ! $UP =~ ^[0-9]+$ ]] || [[ ! $DOWN =~ ^[0-9]+$ ]]; then
            UP=0
            DOWN=0
        fi
        
        # 格式化输出，转换为合适的单位 (KB/s, MB/s等)
        format_speed() {
            local speed=$1
            if [ "$speed" -ge 1048576 ]; then
                # 大于等于 1MB, 显示为 MB/s
                printf "%.1fM" "$(echo "scale=1; $speed/1048576" | bc 2>/dev/null || echo "0")"
            elif [ "$speed" -ge 1024 ]; then
                # 大于等于 1KB, 显示为 KB/s
                printf "%.1fK" "$(echo "scale=1; $speed/1024" | bc 2>/dev/null || echo "0")"
            else
                # 显示为 B/s
                echo "${speed}B"
            fi
        }
        
        # 格式化上行和下行速度
        UP_FORMATTED=$(format_speed "$UP")
        DOWN_FORMATTED=$(format_speed "$DOWN")
        
        # 输出结果
        echo " ${UP_FORMATTED}  ${DOWN_FORMATTED}"
    else
        # 如果无法获取数据，显示错误信息
        echo " 0B  0B"
    fi
done