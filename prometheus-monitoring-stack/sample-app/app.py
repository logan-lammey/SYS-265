from flask import Flask, Response
from prometheus_client import Counter, Histogram, Gauge, generate_latest
import time
import random

app = Flask(__name__)

# Prometheus metrics
REQUEST_COUNT = Counter('app_requests_total', 'Total number of requests')
REQUEST_DURATION = Histogram('app_request_duration_seconds', 'Request duration')
ACTIVE_USERS = Gauge('app_active_users', 'Number of active users')

@app.route('/')
def hello():
    REQUEST_COUNT.inc()
    ACTIVE_USERS.set(random.randint(1, 100))
    time.sleep(random.uniform(0.01, 0.1))
    return '''
    <h1>Sample Monitoring Application</h1>
    <p>This is a sample Python Flask application being monitored by Prometheus.</p>
    <ul>
        <li><a href="/metrics">Prometheus Metrics</a></li>
        <li><a href="/api/data">API Endpoint</a></li>
    </ul>
    '''

@app.route('/api/data')
@REQUEST_DURATION.time()
def get_data():
    REQUEST_COUNT.inc()
    time.sleep(random.uniform(0.05, 0.2))
    return {
        'status': 'success',
        'data': 'Sample data from monitored application',
        'timestamp': time.time()
    }

@app.route('/metrics')
def metrics():
    return Response(generate_latest(), mimetype='text/plain')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
