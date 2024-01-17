# syntax=docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
FROM louislam/uptime-kuma:1.23.11-debian@sha256:c326fd83d8da2d8fff3feb0e47433546139513bd823d9accc12977176b05b31f

# override entrypoint.sh file to support rootless execution of the container
COPY entrypoint.sh /app/extra/entrypoint.sh
RUN chmod +x /app/extra/entrypoint.sh
