FROM python:3.10-slim as base_image

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    POETRY_VERSION=1.4.2

WORKDIR /tmp

RUN pip install "poetry==$POETRY_VERSION"

COPY ./poetry.lock ./pyproject.toml ./

RUN poetry export -f requirements.txt -o requirements.txt && \
    rm poetry.lock pyproject.toml && \
    pip uninstall poetry -y

WORKDIR /app

# Copy app files
COPY treemenu/manage.py .
COPY treemenu/entrypoint.sh .
COPY treemenu/app app
COPY treemenu/static static
COPY treemenu/templates templates
COPY treemenu/treemenu treemenu

EXPOSE 8000

# Applying migrations
ENTRYPOINT ["bash", "entrypoint.sh"]


FROM base_image as image

RUN pip install -r /tmp/requirements.txt && \
    pip install gunicorn

# Run app
CMD ["gunicorn", "treemenu.wsgi:application", "-w", "4", "--bind", "0.0.0.0:8000"]
