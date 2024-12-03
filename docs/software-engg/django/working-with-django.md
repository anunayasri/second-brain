# Working with Django

!!! note
    WIP: These notes may not make sense to you.

Apps: has
```sh
apps.py : App config
migrations/
models.py or models/
views.py or views/
tests.py or tests/
```

Eg polls app -
```py
polls/
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py
```

A view is a “type” of web page in your *Django application* that generally
serves a specific function and has a specific template.

In our poll application, we’ll have the following four views:

1. Question “index” page – displays the latest few questions.
1. Question “detail” page – displays a question text, with no results but with a form to vote.
1. Question “results” page – displays results for a particular question.
1. Vote action – handles voting for a particular choice in a particular question.

URL -> View. How? Using `URLconf` which is used by `URL dispatcher`

## Django Templates

> Display dynamic content on an HTML page

Django uses `Django template language (DTL)` to define templates.
Other templating libs, like Jinja2, can also be used, but DTL is the recommened
way in the Django ecosystem.

Django’s contrib apps that include templates, like `django.contrib.admin`, use the DTL.

A template is *rendered* with a *context*. Rendering replaces variables with their
values, which are looked up in the context, and executes *tags*. Everything else
is output as is.

> Context is a dict-like object mapping keys to values.

DTL involves four constructs -

1. Variables

```
{{ my_dict.key }}
{{ my_object.attribute }}
{{ my_list.0 }}
```

1. Tags

```
# surrounded by {% and %}
{% csrf_token %}

# Most tags accept arguments:
{% cycle 'odd' 'even' %}

# Some tags require beginning and ending tags:
{% if user.is_authenticated %}Hello, {{ user.username }}.{% endif %}
```

1. Filters

```
{{ django|title }}

# Some filters take an argument:
{{ my_date|date:"Y-m-d" }}
```

1. Comment

### Removing hardcoded URLs in templates

Decouple the exact url with the url references in the templates.

```html
-- NOT this
<li><a href="/polls/{{ question.id }}/">{{ question.question_text }}</a></li>

-- Use url tag - {% url %}
<li><a href="{% url 'detail' question.id %}">{{ question.question_text }}</a></li>
```

## Cli commmands

```sh
# ipdb shell with all apps loaded
./manage.py shell_plus

# show urls
# 867 urls on 2024-11-08 
./manage.py show_apps

./manage.py help
```

Generate ERDs

```sh
brew install graphviz
pip install pydotplus
```

```sh
# ERD for all models
python manage.py graph_models -a -o myapp_models.png

```

## Django snippets

Get all apps

```py
from django.apps import apps
app_names = [app.name for app in apps.get_app_configs()]
print(app_names)
```

Get all custom commands

```py
from django.core.management import get_commands

commands = get_commands()
custom_commands = [cmd for cmd, app in commands.items() if app != 'django.core']
print("Custom Commands:", custom_commands)
```

Get all custom commands

```py
from django.core.management import get_commands

commands = get_commands()
custom_commands = [cmd for cmd, app in commands.items() if app != 'django.core']
print("Custom Commands:", custom_commands)
```

## Referencess

- Django by Dr. Chuck: https://www.youtube.com/watch?v=jmX27FrCqqs
