FROM gcr.io/impact-analytics-sandbox/create_base_image:v1

COPY ./serve.py /home/model-server/
COPY ./model.pth.tar /home/model-server/
COPY ./requirements.txt /home/model-server/ 

# install dependencies
RUN apt update -y
RUN pip3 install -r /home/model-server/requirements.txt

# expose health and prediction listener ports from the image
EXPOSE 5050

# run Torchserve HTTP serve to respond to prediction requests
CMD exec gunicorn --bind 0.0.0.0:5050 --chdir /home/model-server/ serve:app

# ENTRYPOINT [ "python3" ]
# CMD [ "/home/model-server/serve.py" ]
# CMD ["python3", "/home/model-server/serve.py"]