#include <reproc/parser.hpp>
#include <reproc/reproc.hpp>

#include <iostream>

int fail(std::error_code ec)
{
  std::cerr << ec.message();
  return 1;
}

/*!
Forwards the program arguments to a child process and prints its output on
stdout.

Example: "./forward cmake --help" will print CMake's help output.

This program can be used to verify that manually executing a command and
executing it with reproc give the same output
*/
int main(int argc, char *argv[])
{
  if (argc <= 1) {
    std::cerr << "No arguments provided. Example usage: ./forward cmake --help";
    return 1;
  }

  reproc::process forward;
  std::error_code ec;

  ec = forward.start(argc - 1, argv + 1);
  if (ec) { return fail(ec); }

  // Some programs wait for the input stream to be closed before continuing
  forward.close(reproc::cin);

  // Pipe child process stdout output to std::cout of parent process
  ec = forward.read(reproc::cout, reproc::ostream_parser(std::cout));
  if (ec) { return fail(ec); }

  // Pipe child process stderr output to std::cerr of parent process
  ec = forward.read(reproc::cerr, reproc::ostream_parser(std::cerr));
  if (ec) { return fail(ec); }

  // wait stores the exit status in exit_status if it succeeds
  unsigned int exit_status = 0;
  ec = forward.wait(reproc::infinite, &exit_status);
  if (ec) { return fail(ec); }

  return static_cast<int>(exit_status);
}
