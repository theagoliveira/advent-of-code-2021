# frozen_string_literal: true

class Answer
  def self.read_input_file
    File.read('input.txt')
  end

  def parse_input(input)
    input.split("\n").map do |line|
      line.split('-')
    end
  end

  def explore_caves(graph, node, visited, paths, small_twice)
    # puts "explore_caves(\n   node: #{node},\nvisited: #{visited},\n  paths: #{paths},\n   path: #{path}\n)"

    return paths + 1 if node == 'end'

    visited[node] += 1
    small_twice ||= small?(node) && visited[node] == 2

    graph[node].each do |cave|
      next unless big?(cave) || visited[cave].zero? || (small?(cave) && !small_twice)

      paths = explore_caves(graph, cave, visited, paths, small_twice)
    end

    visited[node] -= 1

    paths
  end

  def small?(cave)
    cave =~ /^[a-z]+$/ && cave != 'start' && cave != 'end'
  end

  def big?(cave)
    cave =~ /^[A-Z]+$/
  end

  def main
    connections = parse_input(self.class.read_input_file)

    graph = {}
    visited = Hash.new(0)

    connections.each do |(node_from, node_to)|
      (graph[node_from] ||= []) << node_to
      (graph[node_to] ||= []) << node_from
    end

    explore_caves(graph, 'start', visited, 0, false)
  end
end

puts Answer.new.main
