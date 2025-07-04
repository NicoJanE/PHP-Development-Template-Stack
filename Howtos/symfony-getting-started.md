---
layout: default_c
---
<br><br><br>

### Content reference

<sub><b>Item:</b></sub>

1. [Symfony: Getting started](#1-symfony-getting-started)
1. [Symfony: commands](#11-symfony-commands)
1. [Symfony: Packages and Recipes](#12-symfony-packages-and-recipes)
1. [What is Symfony Flex](#13-what-is-symfony-flex)
1. [Coding rules & And first program](#14-coding-rules--and-first-program)
1. [Extend Program with Twig (HTML template library)](#15-extend-program-with-twig-html-template-library)
1. [Render variables in twig](#151-render-variables-in-twig)
1. [Twig Inheritance](#152-twig-inheritance)
1. [Twig Syntax](#153-twig-syntax)
1. [Debug](#16-debug)
1. [Debug Install](#161-debug-install)
1. [Object Types](#17-object-types)
1. [controller Object](#171-controller-object)
1. [Using Services Object](#172-using-services-object)
1. [More about Services and Creating Services](#173-more-about-services-and-creating-services)
1. [Automatic and Manually Services](#1731-automatic-and-manually-services)
1. [Creating our own Application Services](#1732-creating-our-own-application-services)
1. [Dynamic-Routing](#18-dynamic-routing)
1. [Generate Url's](#19-generate-urls)
1. [Asset Mapper](#110-asset-mapper)
1. [CSS Tailwind](#111-css-tailwind)




[Appendix II. console cheat sheet](#appendix-2) <br>
[Appendix III. Visual Studio Code Extensions](#appendix-3) <br>

---



## 1. Symfony: Getting started

This is a concise summary of the fundamentals of PHP Symfony, loosely based on the [SymfonyCasts course](https://symfonycasts.com/tracks/symfony). It is part of the ***PHP Development Template Stack*** Docker container. Once installed, you will find a ***symfony-apps\sample*** directory that supports this file.

> **Alternatively** <br> you can create a new Symfony project from scratch. To do so, follow these steps:
>
- `mkdir apps`
- `cd apps`
- `symfony new projectx  # Creates a new Symfony project in ./apps/projectx`  
>
1. Open ***/usr/local/apache2/conf/extra/httpd-vhosts.conf*** set the **document root** to:
 ``../apps/projectx/public``
1. Restart docker or Apache2
1. In VSC open the container and open the folder: /apps/projectx/

> **Visual Studio Code extensions** <br>
> For a list list of extension for Symfony in VSC, **[See Appendix III](#appendix-3)**

<br>

## 1.1 Symfony commands

Symfony has two distinct CLI tools:

- `symfony  [symfony command]` <br>
 Global CLI to managing Symfony on high level, for example to create a new project )
- Or from the project directory (projectx) <br>
`./bin/console [symfony command]` <br>
This is used to install and configure project  specific pacakges\recipes (managing the project) <br>
  - For a overview of the most important command see [Appendix II](#appendix-2)

## 1.2 Symfony Packages and Recipes

Packages are the libraries of which Symfony is build.
Packages can be installed with `composer require symfony/asset`, which not only installs the package but also applies the associated recipe (configuration). 
Recipes are part of the package installation and can consist of configuration files that set up the package correctly for use in a Symfony project.

Using `composer install symfony/asset` does not install the recipe — it only installs the dependencies listed in the `composer.json` file, and thus doesn't configure the package for use.

When you install a package with `composer require symfony/asset`, the recipe (if available) is automatically applied, configuring the necessary 
files (such as `config/packages/asset.yaml`) for the package.

A command like `./bin/console recipes symfony` will display the **recipes** associated with the installed **packages**, showing their configuration files and locations.

## 1.3 What is Symfony Flex

Composer plugin of Symfony. It add **Aliases** and the **Recipes** mentioned above.
The alias is just a short name for a composer package.

## 1.4 Coding rules & And first program

Not following the following rules, will result  a "a class not found error ..."

- Every class must have a **namespace** and the **namespace** must match the directory structure,and the namespace  always starting with **App/** (while this is not part of directory structure)
- The **class name must** match the **file name** <br>
Below follows an example which is also our first simple application in our new project<br>
***Example:*** <br><br>
  - **File**:  `src/controller/MainController.php`
  - **Content** <br>  
  <pre class="nje-cmd-multi-line">
  <?php
     namespace App\Controller;

      use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
      use Symfony\Component\HttpFoundation\Response;
      use Symfony\Component\Routing\Attribute\Route;

      class MainController extends AbstractController
      {
          ...
      }
  </pre>

> *Note 1*{: style="color: green;font-size:14px; "} The controller directory name is a convention, it represent the main of a subsystem of your app.  <br> <br>
> *Warning 1*{: style="color: red;font-size:14px; "} If something goes **wrong** it is probably due to **missing** of the **.htaccess file** in ./public!  
> *Warning 2*{: style="color: red;font-size:14px; "} When **errors** persist after updating to the **right solution**: execute: `./bin/console cache:clear`  

## 1.5 Extend Program with Twig (HTML template library)

- **Install**:<br>
`composer require twig  # installs & configure twig`
- **Configuration**: <br>
`./root/config/packages/twig.yaml`
- **Template files location**: <br>
  - `./root/template/base.html.twig # Default base file`
  - `./root/template/* # Your twig files an folders`

### 1.5.1 Render variables in twig

Int the PHP source call the render method with the twig file

- ***src/Controller/MainController.php***

<pre class="nje-cmd-multi-line">
<?php
namespace App\Controller;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
class MainController extends AbstractController
{
    #[Route('/')]
    public function homepage(): Response
    {
        $starshipCount = 457;

        $myShip = [
        'name' => 'USS LeafyCruiser (NCC-0001)',
        'class' => 'Garden',
        ];

        return $this->render('main/homepage.html.twig', [
            'numberOfStarships' => $starshipCount,
            'twigShip' => $myShip,  
        ]);
    }
}
</pre>

- ***templates/main/homepage.html.twig***

``` html
<h1>
    Starshop: your monopoly-busting option for Starship parts!
</h1>
<div>
    Browse through {% raw %} {{ numberOfStarships }} {% endraw %} starships! <br>
    Name: {% raw %} {{ twigShip.name }} {% endraw %} <br>
</div>
```

>  ✅ ***Twig, array and object are treated the same*** <br>
> In the example above. When ***twigShip*** is an array with a name attribute or object with a name property\getter does not matter for Twig, it will detect this and work for both the same.
> ss

 
> <small>  ⚠️ **markdown definition** <br>
> {&#37; raw &#37;}...{&#37;; endraw &#37;} is used in this Markdown file (see source) to ensure that **Markdown** correctly interprets the Twig code without processing it. These tags are not part of the actual Twig code itself (they are also not displayed in the result). </small>

### 1.5.2 Twig Inheritance

- In the child twig page define <br>
`{% raw %}{% extends 'base.html.twig' %}{% endraw %}`
- In the base twig define a named block range <br>
`{% raw %}{% block title %}Starshop{% endblock %} {% endraw %}` <br>
You can override  this in the child template like: <br>
`{% raw %}{% block title %} Beam up some parts!{% endblock %} {% endraw %}` <br>
Or you can append it in the child template like: <br>
`{% raw %}{% block title %}{{ parent() }} Starshop: Beam up some parts!{% endblock %} {% endraw %}`

- Sample:  ***templates/main/homepage.html.twig***

``` html
{% raw %}{% extends 'base.html.twig' %}     {% endraw %}
<!-- Reference the 'block body' defined in base, for our variables -->
<!-- Without error: 'A template that extends another one cannot include content ...' -->
{% raw %}{% block body %}      {% endraw %} 
<h1>
    Starshop: your monopoly-busting option for Starship parts!
</h1>
<div>    
    Name: {% raw %} {{ twigShip.name }} {% endraw %} <br>
</div>
{% raw %}{% endblock %}      {% endraw %}
```

### 1.5.3 Twig Syntax

| Command | Explanation |
|:--------|:------------|
|{% raw %} {{ xx }} {% endraw %}  | Display the variable  |
|{% raw %} {{ xx &#124; upper }} {% endraw %}  | Display the variable using filter function (upper),[all](https://twig.symfony.com/doc/3.x/filters/index.html)  |
|{% raw %} {{ xx &#124; upper &#124; title}} {% endraw %}  | Display the variable using combined filters function (upper),[all](https://twig.symfony.com/doc/3.x/filters/index.html)  |
|{%raw%}In **base** template:{ block body %}{% endblock %} {% endraw %}  | **Definition** block which can be referenced by child template, to display the output of the child template/  |
|{%raw%}In **child** template:{ block body %}...{% endblock %} {% endraw %}  | **Contents** between the ... will be used to display the output of the child template at the location of the **definition** in the base template, ***full override***(see next)  |
|{% raw %} {{ parent() }}  {% endraw %}  | when define in the block of the child(block body) it will display the already defined base content, any other varibles will be appended (***append mode***)   |
|{% raw %} {{ include('subpart.html.twig') }} {% endraw %}  | Include twig part  |
|{% raw %} {% for item in twigvar %} ...    {% endfor %} {% endraw %}  | loop through var  |


 


 <br><br>

## 1.6. Debug

You can use the following debug techniques:

- In code use 'dump and die' command `dd(someting)`
- Use logger interface: `LoggerInterface->info()
- For request display request information with `http://localhost:9000/_profiler/`
- Add Debug statusbar to app (**TODO**) `xx`
- console.log

### 1.6.1 Debug install

- **Install**:<br>
`composer require debug  # installs & configure`
  - Adds debug-bundle
  - Adds monolog
  - Adds stopwatch
  - Adds profiler-bundle
  
#### The install enables

- Debug command as listed in 'Appendix II' [see here](#appendix-2) <br> like for example: 
`./bin/console debug:router`
- profile option to inspect the last calls made with:
`http://localhost:8071/_profiler/`

## 1.7 Object Types

These are the different **object type** we can distinguish i Symfony PHP

- ***Controller*** Handles HTTP requests and Responses
  - Extends: AbstractController
  - May have state
  - Orchestrate services, process **requests**, and return **responses**.
- ***Service*** Performs a tasks, is Business logic and reusable, can be autowired
- ***Entity***, handles data/database
- ***Repository***, handles  database queries and data retrieval
- ***DTO*** (**D**ata **T**ransfer **O**bject), carry data between layers, without exposing th database object  
- ***Form***, Validation and transform user input
- ***Event*** represents event triggers
- ***Event listeners/subscribers*** Listen to events and reacts on them

- ***Value*** Immutable contains domain concept (Money)
- ***Twig extension*** Extension fro Twig templates

### 1.7.1 controller Object

A controller object, handles HTTP **Requests** and **Responses** and

- Extends: AbstractController (often)
  - Inherits automatically injected Symfony services, including:
    - Uses **Twig** Contains the: `render(...)` method
    - Adds **URL routing** support using the: `generateUrl(...)` and `redirectToRoute(...)`, `redirect(...)` methods
    - Adds Handling **Forms** through: `CreateForm(...)`
    - Enables **Doctrine** support: `getDoctrine()`
    - enables **JSON responses**: Allows returning structured JSON data: `json(...).`
    - **Security system integration**: `getUser()`
    - **Exception handling**: `createNotFoundException(...)`, `createAccessDeniedException(...)`
- A **controller** is a special kind of **Service** object (see 1.7.3). While this is true they are **not** used like a **typical service**, cause they are designed to be invoked per request and not injected into other services.
- May have **state**
- **Orchestrate services**, process requests, and return responses.
- Typically **not injected in services** (see below)

***Example Controller response object***

``` php
 namespace App\Controller;
 use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
 use Symfony\Component\HttpFoundation\Response;
 use Symfony\Component\Routing\Attribute\Route;
 class StarshipApiController extends AbstractController
 {
    #[Route('/api/starships_static')                    // Make it available via this route: localhost/api/starships_static
    public function getCollection(): Response
    {
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
 }

```

This will respond with a json of the objects after running:localhost:8071/api/starships

> **Remark 1**
If you replace the `$starships` array with a separate data class that has private properties with getters and setters,
 the  line `return $this->json($starships);` will not work without installing the **serializer** service, this happens because, without the serializer service, `$this->json($starships);` only considers public properties, when the serializer is installed the code will work because it also uses the getters to transform the object into JSON.

To **install** the **serializer** service: `composer require serializer`

### 1.7.2 Using Services Object

A service object contains business logic, note: A service is a plain PHP class—it does not need to extend a specific base class or implement an interface. It also:

- Performs tasks
- Supports lazy loading
- Contains business logic
- Services are usually stateless, meaning they don't maintain any internal state between method calls.
- Is reusable
- Services can be low-level (e.g., data access) or high-level (e.g., business logic).
  - Services can be installed by bundles (e.g., Twig, Doctrine) or created as custom service classes in your application.
- Can be **autowired**, which is a form of Dependency Injection (**DI**). For this to work, the service must:
  - Be registered in a **service container,** which can be done in one of two ways:
    - Defined in the src/ directory using **Symfony's namespace conventions** (auto-registered) (see 1.1),"
    - Be defined in the ***service.yaml*** file (see 1.2).  
  - When using autowiring, the constructor (**__construct**) must **type-hint** the required services as parameters. (see 1.3) This allowing Symfony to automatically inject the correct service.
  - Note that autowiring is a feature of the Symfony service container that automatically resolves dependencies based on type-hints in the constructor.
  - Whether a class is **automatically** registered as a **service** depends on the `services.yaml` (see **1.7.4** for details) configuration and Symfony's **namespace conventions.**

***Example Define service container with autowire-able service: LoggerInterface***

``` php
namespace App\Service;              // 1.1 using conventions to define 
                                    // the service container 
use Psr\Log\LoggerInterface;
class MyService                     // 1.1 file:src/Service/Myservice.php
{                                   // Autowiring is done by the Symfony service container and relies on the CTOR to receive the service
    private LoggerInterface $logger;
    public function __construct(LoggerInterface $logger)    // 1.3 Type hint, the autowire-able service (dependency injection)
    {
        $this->logger = $logger;
    }

    public function doSomething(): void
    {
        $this->logger->info('Doing something');
    }
}
```

***Example use the autowire service container within a:*** **controller**

``` php
namespace App\Controller;
use App\Service\MyService;                                  // 1.) Our service
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Psr\Log\LoggerInterface;                                // 2.) A service from one of the libraries/bundles (./bin/console debug:container)

class MyController extends AbstractController
{
    // 1) MyController has access to MyService via autowiring
    private myLogService $myLogService;                     
    public function __construct(MyService $myLogService)   // CTOR Injection (autowiring enabled)
    {
        $this->myLogService = $myLogService;
    }

    // 2) Autowire LoggerInterface directly in the controller method (only works for controllers)
    public function getCollection(LoggerInterface $logger): Response
    {

    }
    // ... use $myLogService
}
```

📍 Notice: The autowiring in a method (getCollection)only works for **controller** objects


***Example use the autowire service container within another:*** **service**

``` php
namespace App\Service;
use App\Service\MyService;            // Our service   

class AnotherService
{
    private MyService $myLogService;  
    
    public function __construct(MyService $myLogService)    // Constructor injection with autowiring (dependency injection)  
    {                                                       // because MyService is autowired     
        $this->myLogService = $_myLogService;
    }

    public function performAction(): void
    {        
        $this->myLogService->doSomething();
    }
}

```

### 1.7.3 More about Services and Creating Services

In prince every class can become a **service class**. Some class will become **automatically** a service class, and some class can be added **manually** as a service class. How doe this work? where is this defined?

#### 1.7.3.1 Automatic and Manually Services

How a class becomes an automatic service class, is defined in the **`service.yaml`** file. By default it has:
(The 'Manually part' is not part of the default )

``` php
    services:
    # default configuration for services in *this* file
    _defaults:
        autowire: true      # Automatically injects dependencies in your services.
        autoconfigure: true # Automatically registers your services as commands, event subscribers, etc.

    App\:                   # Main namespace for every class in the ../src folder
        resource: '../src/' # This defines that all class in ../src directory and in the sub directories will be come automatically services
                            # if they follow Symfony's service conventions
        exclude:            # EXCEPT for the directories and files listed below:
            - '../src/DependencyInjection/'
            - '../src/Entity/'
            - '../src/Kernel.php'

    # Manually part: Register a specific class explicitly (The resource property is not allowed here—it is only for directories.)
    # Explicitly define a specific service (optional if it already falls under the above rule)
    App\Entity\EntityService:    
        autowire: true
        autoconfigure: true

```

> **What Are Symfony's Service Conventions?**
>
Symfony automatically registers services based on these conventions:
>
1. Namespace & Directory: Classes in the App\ namespace and src/ directory are treated as services unless excluded (e.g., Entity/, Kernel.php).
1. Autowiring: Dependencies are injected automatically if they are type-hinted in the constructor.
1. No Manual Registration Needed: If a class follows these rules, it’s auto-registered as a service—no need to add it explicitly to services.yaml.

> **Display available services**
>
Use this command: `./bin/console debug:container`

#### 1.7.3.2 Creating our own Application Services

1. Create a class in `src/MyRepository/MyTaskCounter.php`:

```php
<?php

namespace App\MyRepository;
class MyTaskCounter
{
    // Class content here
}
```

This class is now a service because:

- It resides in the `src/` directory, which follows Symfony's service conventions (as defined in `services.yaml`).
- It is not located in an excluded directory (e.g., src/Entity/ or src/DependencyInjection/)
- It use the other **Symfony service conventions**
(see `service.yaml` in 1.7.4.1)

Now, `MyTaskCounter` can be injected as a service, in a:

1. Controller method
2. Constructor of any class

**Autowiring other Services in the New service Class**
Your new service (MyTaskCounter) can also have its own dependencies injected (via autowiring). For example:

```php
<?php
use Psr\Log\LoggerInterface;        // service from the logger bundle

namespace App\MyRepository;
class MyTaskCounter
{
    // The LoggerInterface is automatically injected by Symfony
    public function __construct(private LoggerInterface $logger)
    {
    }

}

```

In this example, the `LoggerInterface` service is automatically injected into the `MyTaskCounter` class constructor when the service is used, thanks to autowiring.




## 1.8 Dynamic Routing

This add on to controller example in 1.7.1 here, a sample of controller with dynamic routing

``` php
    // see also the **Sample** Synfomy app. this file: src/Controller/StarshipApiController.php

    // Example 1
    // #[Route('/api/starships')]                          // Make it available via  localhost/api/starships/
    #[Route('/api/starships', methods: ['GET'])]           // Same, but more specific, no conflict with example 3
    public function getAll(StarshipRepository $repo): Response                     // 
    {
        $items =$Repo->findAll();                          // Service to fetch all items and return them 
        return $this->json($items);
    }

    // Example 2.1
    #[Route('/api/starship/ById1/{id}')]                 // Make it available via  localhost/api/starship/4
    public function getById($id): Response               // Id must match and will accept al kind of variables; int, string 
    {
        // Service to fetch id item and return it
    }

    // Example 2.2
    // Only accept integers, if called with: localhost/api/starships/test -> 404 
    #[ Route('/api/starship/ById2/{id<\d+>}', methods: ['GET'], name:'app_get_by_id' ) ] // between <> is a regular expression                   
    public function getById(int $id, StarshipRepository $repo)): Response    // Id must match and will accept only int
    {
        $item =$starshipRepository->find($id);
        if (!$item) {
            throw $this->createNotFoundException('Starship not found');      // send 404
        }
        return $this->json($item);
    }

    // Example 3
    // This uses same route as example, but due POST indication it is not conflicting!
    #[ Route('/api/starship', methods: ['POST'], name:'app_create' ) ]      // name: app_create  -> see next chapter: 1.8                 
    public function Create(): Response
    {
       return $this->json("succesfully created");
    }


```

## 1.9 Generate URLs

To link to other URL in **Twig** we can use the urls the 'internal url name' of a route, which is generated, but this can also be specified explicit, this has been used in the previous code(see examples,2.2 and 3) where this is defined:

- ``#[ Route('/api/starship', methods: ['POST'], name:'app_create' ) ]``

After this you could execute this command and notice the 'app_create' internal name.
`./bin/console debug:router`. This url now enables us to **call** the Create method like this:

- ``{% raw %} <a href="{{ path('app_create') }}"> Create new ship</a> {% endraw %}``

In case you define a route name for the **getById** method, like:

- ``#[ Route('/api/starship/ById2/{id<\d+>}', methods:['GET'], name:'app_get_by_id') ]``

You will need to include the parameter that the method expects 

- ``{% raw %} <a href="{{ path( 'app_get_by_id', { id: myShip.id }) }}"> Show Details</a> {% endraw %}``

## 1.10 Asset Mapper

Images and CSS, should not be placed in the public directory, instead we should use the **Asset Mapper**

- **Install**: '`composer require symfony/asset-mapper`
  - Result: Directory: /assets
  - Results File: config/packages/asset_mapper.yaml
- **Install**: `composer require symfony/asset # To display the images`

This will gives use the **assets** and **assets/styles** directories which can be used for images and CSS Stylesheets.
In the file **asset_mapper.yaml** the **paths** keyword is set to :'assets` the result is that all files, and files in sub folders, in this folder are public available (like they are part of public)

- Use this command to display which files are exposes as asset
  - `- Install: './bin/console debug:asset'`
  
It will display the **logical path** which can be used to reference the files. If for example you have a image file like: `/assets/images/myImage.png`

You can **reference** that file in **Twig** like: <br>
``{% raw %}  <img src="{{ asset('images/starshop-logo.png') }}" > {% endraw %}``

### Version management

An image is automatically translated into a **hash** in the html source code, this makes sure that a changed file always gets a new name and it is not cached!

## 1.11 CSS Tailwind

For example use **Tailwind**

- **Install**: `composer require symfonycasts/tailwind-bundle`
After install you must **run** the following command **one** time:
  - `./bin/console tailwind:init`
    - Result: creates a ***tailwind.config.js*** which contains directions for our css file (asset mapper)
    - Result: It also updates our ***app.css*** file with the Tailwind  references
  - Next 'Tailwind needs to be **build**  
    - `php bin/console tailwind:build -w  # -w watch mode, for scanning changes`

## 1.12 Java-Script

You can use the Javascript file that comes along with the asset mapper: ***/assets/app.js***
As an alternative you can install the ***Stimulus*** library, this library enables you to assign a **controller** to your **html** code, from this control you can then call method defined in the library.

- **Install**: `composer require symfony/stimulus-bundle`
- Result: It adds an import to our ***assests/app.js*** file
- Result: It created a ***assests/bootstrap.js*** file, to start the engine
- Result: It adds  library packages to  ***/importmap.php*** file
- Lastly it created directory ***controllers*** where our Stimulus controllers live, also an **example** controller has been created called ***hello_controller.js***

>There is a naming convention; the file ***hello_controller.js*** should be referenced in html as: **data_controller="hello"**

### How it works

This displays how the function in ****hello_controller.js*** can be called

``` html
<a data-controller=hello> Test </a>
```

## 1.13 Other notable libraries 

- You could consider ***Turbo*** to  prevent full page reload. install it with:
  - `composer require symfony/ux-turbo`
    - Result: Without future configuring the Turbo engine will automatically create AJAX calls and thus prevent full page reloads! Note also that the Symfony web debug toolbar notice and supports the AJAX calls.

> **Be-aware** <br>
Not all Javascript libraries do support Turbo(actually AJAX) they expect a full page reload, so be carefull with selecting your Javascript library! Regarding **Stimulus** this support **Turbo**!

<br><br><br>

<hr>

<a name="appendix-1"/>
# Appendix I, composer cheat list

Composer command

| Command | Explanation |
|:--------|:------------| 
| `composer install`                | Installs dependencies from composer.<BR> lock (or composer.json if composer.lock is missing).|
| `composer update`                 | Updates dependencies to the latest versions allowed by composer.json |
| `composer require package/name`   | installs package -> composer require monolog/monolog |
| `composer show`                   | Lists all installed packages +versions |
| `composer show [package]`         | List specific  installed packages +versions |
| `composer outdated`               | Shows outdated packages|
| `composer why-not package/name`   | Shows why a package cannot be installed or updated. |
| `composer dump-autoload`          | Regenerates the autoload.php file (useful when adding new classes manually)|
| `composer diagnose`               | |
| `composer clear-cache`            | |
| `composer show --direct`          | Displays direct dependencies |
| `composer show Symfony/*`         | Displays components need for Symfony|
| `composer depends twig/twig`      | Which depends on twig/twig |
| `composer why twig/twig`          | Same as above |

<br>

<a name="appendix-2"/>
# Appendix II, Symfony commands

Some important Symfony commands are specified here:

| ***Command*** | ***Explanation*** |
|:--------|:------------| 
| `./bin/console     `                                  | Displays all available Symfony <br>commands  |
| `./bin/console [symfony cmd] -H`                      | Displays help regarding the <br>command 'symfony cmd'|
| `./bin/console  debug:container --parameters   `      | Displays container configuration<br> params, high level |
| `./bin/console  debug:config [framework]  `           | Display configuration of a specific <br> component(framework, twig...)  |
| `./bin/console  debug:container doctrine   `          | Displays all related services of <br>doctrine (classes, ID's) 
| `./bin/console  config:dump-reference [framework] `   | Displays all possible and default <br> config from the component |
| `./bin/console  debug:router   `                      | Displays all defined routers and related<br> info (methods...) |
| `./bin/console  debug:router _api_/status_get   `     | Displays specific router info. (class, path,<BR> methods...) |
| `./bin/console  debug:router --method=GET   `         | Routes using Get operations |
| `./bin/console  router:match /lucky/number/8   `      | Routes with specific name |
| `./bin/console  recipes Symfony   `                   | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |
| `./bin/console     `                                  | x |

<br>

<a name="appendix-3"/>
# Appendix III. Visual Studio Code Extensions
The following are the minimal required extensions. You can Install these from the CLI with:

>**`code --install-extension <extension-id>`**


| ***Extension ID*** | ***Explanation*** |
|:--------|:------------| 
| `bmewburn.vscode-intelephense-client`                | Basic PHP  |
| `DEVSENSE.phptools-vscode`                           | Symfony Namespace insertion  |
| `mblode.twig-language-2`                             | twig (HTML template render)  |
| `SplasHmiCH.symfony-vscode-fixed`                    | auto complete YML XAML, hover on services  |
| `jaguadoromero.vscode-php-create-class`              | PHP create class/Trait/Enum  |
| `st-pham.php-refactor-tool`                          | Refactor items(class, ) => context or F2  |
| `ctf0.vscode-php-getters-setters-new`                | F1 Php Getters/Setters  |
| `christian-kohler.path-intellisense`                 | Consider: Path Intellisense   |
| `cweijan.vscode-mysql-client2)`                      | Consider: MYSQL/MariaDB/Redis and others  |
| `ctf0.local-history-new`                             | Consider: Local file history  |
| `brpaz.file-templates`                               | Consider:create pre defined twig template |


> Reminder use CTRL+t in VSC to go to the definition
