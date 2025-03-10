<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

// devonray.snippet 
class MainController extends AbstractController
{
    #[Route('/')]
    public function homepage(): Response
    {
        opcache_reset();
        $starshipCount =2421;
        return $this->render(   'main/homepage.html.twig',[
                                'numberOfStarships' => $starshipCount,]);
    }

}
