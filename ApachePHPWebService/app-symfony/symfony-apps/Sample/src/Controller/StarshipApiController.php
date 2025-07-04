<?php

namespace App\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use App\Repository\StarshipRepository;

class StarshipApiController extends AbstractController
{
   #[Route('/api/starships_static')]                      // Make it available via this route: localhost/api/starships
   public function getCollection(): Response
   {
       // Example 0 
       $starships = [  // This simulates the data of a repository object, see Remark 1
           [
               'name' => 'USS Espresso (NCC-1234-C)',
               'class' => 'Latte',                  
           ],
           [
               'name' => 'USS Wanderlust (NCC-2024-W)',
               'class' => 'Delta Tourist',
           ],
       ];
       return $this->json($starships);     // See Remark 1
   }


    // Example 1
    // #[Route('/api/starships')]                          // Make it available via  localhost/api/starships/
    #[Route('/api/starships', methods: ['GET'])]            // Same, but more specific, no conflict with example 3
    public function getAll(StarshipRepository $starshipRepository ): Response
    {
        $items =$starshipRepository->findAll();            // Service to fetch all items and return them 
        return $this->json($items);
        
    }

    // Example 2.1
    #[Route('/api/starship/ById1/{id}')]                 // Make it available via  localhost/api/starship/4
    public function getById1($id, StarshipRepository $starshipRepository  ): Response   // Id must match and will accept al kind of variables; int, string 
    {
        $item =$starshipRepository->find($id);
        return $this->json($item);
    }

    // Example 2.2
    // Only accept integers, if called with: localhost/api/starships/test -> 404 
    #[ Route('/api/starship/ById2/{id<\d+>}', methods: ['GET'], name:'app_get_by_id') ] // between <> is a regular expression                   
    public function getById2(int $id, StarshipRepository $starshipRepository): Response // Id must match and will accept only int
    {
        $item =$starshipRepository->find($id);
        if (!$item) {
            throw $this->createNotFoundException('Starship not found');
        }
        return $this->json($item);
        
    }

    // Example 3
    // This uses same route as example, but due POST indication it is not conflicting!
    #[ Route('/api/starship', methods: ['POST'], name:'app_create' ) ] // create fixed name to refrence in twig for example                   
    public function Create(): Response
    {
        return $this->json("succesfully created");
    }
}