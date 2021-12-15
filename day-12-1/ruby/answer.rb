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

  def explore_caves(graph, node, visited, paths, path)
    # puts "explore_caves(\n   node: #{node},\nvisited: #{visited},\n  paths: #{paths},\n   path: #{path}\n)"

    if node == 'end'
      path.push(node)
      paths.append(path.dup)
      path.pop

      return
    end

    path.push(node)
    visited[node] = true if small?(node)

    graph[node].each do |cave|
      next if visited[cave]

      explore_caves(graph, cave, visited, paths, path)
    end

    path.pop
    visited[node] = false if small?(node)
  end

  def small?(cave)
    cave =~ /[a-z]/
  end

  def big?(cave)
    cave =~ /[A-Z]/
  end

  def print_graph(graph)
    puts "\nGRAPH"

    graph.each do |node, adj|
      puts format('%<node>5s: %<adj>s', node: node, adj: adj)
    end
    puts "\n\n"
  end

  def main
    connections = parse_input(self.class.read_input_file)

    graph = {}
    visited = Hash.new(false)

    # puts "\nCONNECTIONS"
    # puts connections.to_s
    connections.each do |(node_from, node_to)|
      (graph[node_from] ||= []) << node_to
      (graph[node_to] ||= []) << node_from
    end

    # print_graph(graph)

    paths = []

    explore_caves(graph, 'start', visited, paths, [])

    # puts "\nPATHS"
    # puts paths.to_s
    paths.length
  end
end

puts Answer.new.main
