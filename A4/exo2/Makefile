CXX=gcc
CFLAGS=-Wall -fopenmp -O3
LDLIBS=-lm
target=exo2

$(target): $(target).c
	$(CXX) $(CFLAGS) $(target).c -o $(target) $(LDLIBS)

clean:
	rm -f $(target)
