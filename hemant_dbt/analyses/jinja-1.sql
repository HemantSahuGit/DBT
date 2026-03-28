{%- set apples = ["red", "green", "yellow"] -%}

{% for apple in apples %}
    {% if apple == "red" %}
        {{ apple }}
    {% else %}
        I do not like {{ apple }}
    {% endif %}
{% endfor %}