// #include "../../includes/minishell.h"
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void	ft_putstr(char *str)
{
	if (!str)
		return;
	while(*str)
		write(1, str++, 1);
}

size_t	ft_strlen(const char *str)
{
	const char *ptr;
	
	ptr = str;

	if(!str)
		return (0);
	while(*ptr)
		ptr++;
	return(ptr - str);
}

char	*ft_strdup(const char *str)
{
	char	*ptr;
	char	*start;

	if (!str)
		return (NULL);
	ptr = malloc(sizeof(char) * ft_strlen(str) + 1);
	if(!ptr)
		return(NULL);
	start = ptr;
	while(*str)
		*ptr++ = *str++;
	*ptr = '\0';
	return (start);
}



int	main(void)
{
	char *str = "salut les gens\t\n ";
	char *dup;

	ft_putstr(str);
	printf("len = %ld\n", ft_strlen(str));

	dup = ft_strdup(str);
	printf("dup = %s\n->end", dup);
	free(dup);
	return (0);
}