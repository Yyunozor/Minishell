#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    setup.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: minishell <minishell@student.42.fr>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/28 00:00:00 by minishell         #+#    #+#              #
#    Updated: 2025/06/28 00:00:00 by minishell        ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Simple setup wrapper script that calls the cross-platform setup

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Call the cross-platform setup script
exec "$SCRIPT_DIR/cross_platform_setup.sh" "$@"
