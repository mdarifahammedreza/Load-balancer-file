#!/bin/bash

# ==========================================
# NGINX LOAD BALANCER DEMO PAGE SETUP
# Powered by Ostad
# ==========================================

# Update packages
sudo apt update -y

# Install nginx + curl
sudo apt install -y nginx curl

# Enable and start nginx
sudo systemctl enable nginx
sudo systemctl start nginx

# Fetch server details
SERVER_IP=$(curl -s ifconfig.me)
HOSTNAME=$(hostname -f)

# Create modern animated HTML page
sudo tee /usr/share/nginx/html/index.html > /dev/null <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Load Balancer Demo</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            overflow:hidden;
            font-family:'Segoe UI', sans-serif;

            background:
                radial-gradient(circle at top left, #1e3c72, transparent 35%),
                radial-gradient(circle at bottom right, #2a5298, transparent 35%),
                linear-gradient(135deg, #0f172a, #111827, #1e293b);

            position:relative;
        }

        /* Animated Glow Circles */
        .circle{
            position:absolute;
            border-radius:50%;
            filter:blur(20px);
            opacity:0.5;
            animation:float 10s infinite ease-in-out;
        }

        .circle:nth-child(1){
            width:250px;
            height:250px;
            background:#00f5ff;
            top:5%;
            left:5%;
        }

        .circle:nth-child(2){
            width:300px;
            height:300px;
            background:#8b5cf6;
            bottom:5%;
            right:8%;
            animation-duration:14s;
        }

        .circle:nth-child(3){
            width:180px;
            height:180px;
            background:#38bdf8;
            bottom:15%;
            left:15%;
            animation-duration:8s;
        }

        @keyframes float{
            0%{
                transform:translateY(0px) scale(1);
            }

            50%{
                transform:translateY(-30px) scale(1.08);
            }

            100%{
                transform:translateY(0px) scale(1);
            }
        }

        /* Main Card */
        .container{
            position:relative;
            z-index:10;
            width:720px;
            padding:55px;
            border-radius:28px;

            background:rgba(255,255,255,0.08);
            backdrop-filter:blur(18px);

            border:1px solid rgba(255,255,255,0.12);

            box-shadow:
                0 0 30px rgba(0,0,0,0.45),
                inset 0 0 12px rgba(255,255,255,0.05);

            text-align:center;
            transition:0.4s ease;
        }

        .container:hover{
            transform:translateY(-10px) scale(1.02);

            box-shadow:
                0 0 45px rgba(0,245,255,0.25),
                0 0 80px rgba(139,92,246,0.18);
        }

        h1{
            font-size:60px;
            font-weight:800;

            background:linear-gradient(
                90deg,
                #00f5ff,
                #8b5cf6,
                #38bdf8
            );

            -webkit-background-clip:text;
            -webkit-text-fill-color:transparent;

            animation:shine 4s linear infinite;

            margin-bottom:20px;
        }

        @keyframes shine{
            0%{
                filter:brightness(1);
            }

            50%{
                filter:brightness(1.5);
            }

            100%{
                filter:brightness(1);
            }
        }

        .subtitle{
            color:#dbeafe;
            font-size:22px;
            margin-bottom:35px;
            letter-spacing:0.5px;
        }

        .info-box{
            margin-top:22px;
            padding:24px;
            border-radius:22px;

            background:rgba(255,255,255,0.06);

            border:1px solid rgba(255,255,255,0.08);

            transition:0.35s ease;
        }

        .info-box:hover{
            transform:scale(1.04);

            border-radius:45px;

            background:rgba(255,255,255,0.12);

            box-shadow:
                0 0 25px rgba(0,245,255,0.18);
        }

        .label{
            color:#93c5fd;
            font-size:17px;
            margin-bottom:12px;
            text-transform:uppercase;
            letter-spacing:2px;
        }

        .ip{
            color:white;
            font-size:34px;
            font-weight:bold;
            text-shadow:0 0 15px rgba(0,245,255,0.5);
        }

        .hostname{
            color:#f8fafc;
            font-size:24px;
            font-weight:600;
        }

        .footer{
            margin-top:40px;
            color:#cbd5e1;
            font-size:18px;
        }

        .footer span{
            background:linear-gradient(90deg,#00f5ff,#8b5cf6);
            padding:8px 18px;
            border-radius:999px;
            color:white;
            font-weight:bold;
            box-shadow:0 0 15px rgba(139,92,246,0.4);
        }

        .badge{
            display:inline-block;
            margin-top:15px;
            padding:10px 18px;
            border-radius:50px;
            background:#22c55e;
            color:white;
            font-size:15px;
            font-weight:bold;
            animation:pulse 2s infinite;
        }

        @keyframes pulse{
            0%{
                transform:scale(1);
                box-shadow:0 0 0 rgba(34,197,94,0.5);
            }

            50%{
                transform:scale(1.08);
                box-shadow:0 0 25px rgba(34,197,94,0.7);
            }

            100%{
                transform:scale(1);
                box-shadow:0 0 0 rgba(34,197,94,0.5);
            }
        }

    </style>

</head>

<body>

    <!-- Background Glow -->
    <div class="circle"></div>
    <div class="circle"></div>
    <div class="circle"></div>

    <!-- Main Card -->
    <div class="container">

        <h1>WELCOME</h1>

        <p class="subtitle">
            🚀 Load Balancing Lab Environment
        </p>

        <div class="badge">
            Server Online
        </div>

        <div class="info-box">
            <p class="label">Public IP Address</p>
            <p class="ip">$SERVER_IP</p>
        </div>

        <div class="info-box">
            <p class="label">Hostname</p>
            <p class="hostname">$HOSTNAME</p>
        </div>

        <div class="footer">
            Powered by <span>Ostad</span>
        </div>

    </div>

</body>
</html>
EOF

# Restart nginx
sudo systemctl restart nginx


sudo rm -f /var/www/html/index.html
sudo cp /usr/share/nginx/html/index.html /var/www/html/index.html
# Status message
echo "====================================="
echo " NGINX SERVER PAGE DEPLOYED"
echo "====================================="
echo " Server IP : $SERVER_IP"
echo " Hostname  : $HOSTNAME"
echo "====================================="
