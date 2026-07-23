json.meta do
  json.total_pages @total_pages
  json.current_page @current_page
  json.next_page @next_page
  json.prev_page @prev_page
end

json.pokemons @paged_pokemons do |pokemon|
  json.partial! 'api/pokemons/pokemon', pokemon: pokemon
end
