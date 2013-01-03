
# Rebuild all indexes daily and notify searchd.
@daily      <%= @user %> . /etc/default/sphinxsearch && [ "$START" = "yes" ] && [ -x <%= @install_path %>/bin/indexer ] && <%= @install_path %>/bin/indexer --quiet --rotate --all

# Example for rotating only specific indexes (usually these would be part of
# a larger combined index).

# */5 * * * * <%= @user %> [ -x <%= @install_path %>/bin/indexer ] && <%= @install_path %>/bin/indexer --quiet --rotate postdelta threaddelta

