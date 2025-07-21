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

char	*ft_strjoin(char const *s1, char const *s2)
{
	char	*joined_str;
	char	*ptr;
	size_t	s1_len;
	size_t	s2_len;

	if (!s1 || !s2)
		return (NULL);
	s1_len = ft_strlen(s1);
	s2_len = ft_strlen(s2);
	joined_str = (char *)malloc(sizeof(char) * (s1_len + s2_len + 1));
	if (!joined_str)
		return (NULL);
	ptr = joined_str;
	while (*s1)
		*ptr++ = *s1++;
	while (*s2)
		*ptr++ = *s2++;
	*ptr = '\0';
	return (joined_str);
}

 

int	main(void)
{
	char *str = "salut les gens\t ";
	char *str2 = "\t\t\tet aurevoir !";
	char *dup;
	char *join;

	ft_putstr(str);
	printf("len = %ld\n", ft_strlen(str));

	dup = ft_strdup(str);
	printf("dup = %s\n", dup);
	free(dup);
	join = ft_strjoin(str, str2);
	printf("join = %s\n", join);

	printf("end\n");
	return (0);
}