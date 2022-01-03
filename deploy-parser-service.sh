## THIS SCRIPT I CREATED WHEN DEPLOYING THE PYTHON BASED MICROSOERVICE TO EC2-INSTANCE USING CONDA ENVIRONMENT ###



echo "Resume parser deployment script";

echo "Checking if processes are already running"
sudo pgrep -f "gunicorn"
if sudo pgrep -f "gunicorn"
then
echo "Parser process is already running killing it"
sudo pkill -f "gunicorn"
echo "existing processes were killed"
else 
echo "No existing process running at present"
fi

sudo -i -u sahil bash << EOF
cd /opt/apps/source/resume-pipeline-python
echo "Current branch is" 
git branch
echo "Pulling latest code!"
git pull

echo "Deploying the latest version of application"

source /home/sahil/miniconda3/bin/activate parser

gunicorn -k uvicorn.workers.UvicornWorker main:app --daemon --bind 0.0.0.0:10015 &

echo "Application deployed please check on URL http://<URL>:10015/docs"

EOF
