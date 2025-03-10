<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;

class MainController extends AbstractController
{
    public function homepage(): Response
    {
        $starshipCount = 457;
        return $this->render(   'main/homepage.html.twig',[
                                'numberOfStarships' => $starshipCount,]);
    }

}
