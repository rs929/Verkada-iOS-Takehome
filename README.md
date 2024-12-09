# PokedexApp

A SwiftUI-based Pokémon gallery app designed to display Pokémon details using a grid layout, with dynamic pagination and image caching (For Verkada iOS Takehome)

## Additional Features:
- Pokemon Type Display
- Pokemon Summary Info
- Pokemon Shiny Toggle
- Loading States

## Challenges:
One of the largest challenges faced was figuring out the logic needed to fetch all the Pokedex entries and then proceed to fetch all the pokemon details for each entry, that way we are able to display the sprite as well as the name of the pokemon.
The API provides Pokedex entries as a paginated list (pokemon?limit=N&offset=M), and each entry contains a URL to fetch additional details (e.g., name, sprite) for that specific Pokémon. In order to efficiently handle this logic, I needed to first fetch the Pokedex entries in a paginated manner, then concurrently fetch details for each Pokémon, and lastly, handle potential errors while ensuring the application remains responsive.
In my implementation, I decided to use an AsyncAwait concurrency model and task groups to ensure that the pokemon details are fetched concurretly after all entries are fetched, and also by using withThrowingTaskGroup(), this ensures that any errors are propogatee while other tasks are still able to be completed, in the case that fetching a specific pokemon details leads to an error

## Technical Decisions:
When considering the pokemon types, the original plan was to utilize the API to fetch the pokemon type images; however, after looking at the resulting data json, it seemed like there was so many nested layers for the type that it seemed better for the sake of time to just utilize assets and encode the name to an asset image rather than creating 5-6 new structs just for a singular image and also have to deal with a task group to fetch each of the types.

I also decided when implementing the networking to utilize a more scalable approach rather than hard coding each endpoint separately, I created a template get function that performs most of the logic needed to fetch the information from the API so that in case there are any structual changes to the API, then I can handle it in one place rather than changing it for each endpoint call. Furthermore, this significantly reduces code repetition since I have a centralized function that handles the URLSession request, the decoding as well as error and response handling



