function vi
{% if ansible_system == 'Linux' %}
    command vis $argv
{% else %}
    command vim $argv
{% endif %}
end
