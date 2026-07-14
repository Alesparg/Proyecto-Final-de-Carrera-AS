# UNIVERSIDAD NACIONAL DEL LITORAL
## Facultad de Ingeniería y Ciencias Hídricas
### Tecnicatura en Diseño y Programación de Videojuegos
**Proyecto Final**

---

# GAME DESIGN DOCUMENT (GDD)

**Nombre del Juego:** [Defensa de Colonias Espaciales]  
**Versión:** 1.0.0  
**Fecha de actualización:** [13/07/2026]

## Ficha del Grupo
| Apellido y Nombre Completo | Función dentro del grupo |
| :--- | :--- |
| [Alejandro Spengler] | Game Designer / Level Design |
| [Alejandro Spengler] | Artist |
| [Alejandro Spengler] | Programmer |
| [Alejandro Spengler] | Producer |

---

## 1. High Concept y Visión Inicial

High Concept: "Defensa de Colonias Espaciales es un Tower Defense de ciencia ficción donde el jugador controla una inteligencia artificial militar para proteger las últimas colonias humanas mediante la construcción estratégica de torretas, la gestión de recursos y la adaptación a eventos dinámicos y oleadas de enemigos extraterrestres."

> <img width="925" height="713" alt="image" src="https://github.com/user-attachments/assets/0f020b63-45b3-4251-9fd5-a41d715c0405" />



---

## 2. Estructura Core del Proyecto

### 2.1 Objetivo del Proyecto

El objetivo de este proyecto es desarrollar un videojuego del género Tower Defense ambientado en un universo de ciencia ficción, donde el jugador debe proteger colonias espaciales de invasiones extraterrestres mediante la construcción estratégica de torretas, la gestión de recursos y la investigación de nuevas tecnologías.

A nivel de producto, se busca crear una experiencia entretenida, accesible y desafiante, que combine planificación estratégica, progresión constante y una alta rejugabilidad gracias a la variedad de enemigos, mejoras y eventos dinámicos que pueden ocurrir durante las partidas.

A nivel académico, el proyecto tiene como finalidad aplicar los conocimientos adquiridos durante la carrera de Tecnicatura en Diseño y Programación de Videojuegos, poniendo en práctica conceptos de diseño de videojuegos, programación, desarrollo de mecánicas, diseño de interfaces, balance de juego y gestión de proyectos. Además, busca servir como experiencia integral de desarrollo y como una pieza representativa para el portafolio profesional del alumno

### 2.2 Diseño e investigación
**Definición de idea**

Defensa de Colonias Espaciales es un videojuego de estrategia del género Tower Defense ambientado en un futuro donde la humanidad ha abandonado la Tierra y sobrevive en colonias espaciales distribuidas por la galaxia. El jugador controla a ATLAS, una inteligencia artificial militar encargada de proteger los núcleos energéticos de las colonias frente a la invasión de una raza extraterrestre. Para lograrlo deberá construir y mejorar torretas, administrar recursos, investigar nuevas tecnologías y adaptarse a diferentes tipos de enemigos y eventos dinámicos que modificarán el desarrollo de cada partida.

**Género**

•	Estrategia.

•	Tower Defense.

•	Ciencia ficción.

**Referencias**

El proyecto toma inspiración de diversos juegos del género Tower Defense y de la estética de la ciencia ficción:

•	Kingdom Rush: por su sistema de defensa mediante torretas, variedad de enemigos y progresión.

•	Bloons TD 6: por su sistema de mejoras, árboles de habilidades y dificultad progresiva.

•	Plants vs. Zombies: por la administración de recursos y la accesibilidad de sus mecánicas.

•	Defense Grid: The Awakening: por su ambientación futurista y el enfoque estratégico.

•	También toma como referencia la estética de películas de ciencia ficción ambientadas en conflictos espaciales, con tecnología avanzada, estaciones espaciales y batallas entre la humanidad y civilizaciones extraterrestres.

**Público objetivo**

El juego está dirigido a jugadores de entre 12 y 35 años que disfrutan de títulos de estrategia y planificación. Está pensado tanto para jugadores casuales que buscan partidas de entre 10 y 20 minutos como para jugadores más experimentados que desean optimizar estrategias, desbloquear mejoras y superar desafíos cada vez más complejos.

**Mecánicas principales**

Las acciones que el jugador realizará de forma constante durante la partida son:

•	Construir torretas defensivas en posiciones estratégicas.

•	Administrar la energía y los créditos disponibles.

•	Mejorar las torretas existentes para aumentar su eficacia.

•	Defender el núcleo energético de cada colonia frente a oleadas de enemigos.

•	Adaptar la estrategia según el tipo de enemigo y los eventos dinámicos que ocurran durante la misión.

•	Desbloquear nuevas tecnologías y mejoras permanentes para afrontar niveles cada vez más difíciles.


### 2.3 Concepto del Juego
Defensa de Colonias Espaciales transcurre en un futuro lejano donde la humanidad ha agotado los recursos de la Tierra y se ha visto obligada a colonizar distintos sectores de la galaxia. Estas colonias representan los últimos refugios de la civilización humana, pero una poderosa raza extraterrestre conocida como los Vorak inicia una invasión con el objetivo de conquistar el espacio y destruir toda presencia humana.

Ante esta amenaza, se activa ATLAS (Autonomous Tactical Logistic And Security System), una inteligencia artificial militar diseñada para coordinar la defensa de las colonias. El jugador asume el control de ATLAS y debe proteger los núcleos energéticos de cada colonia utilizando una combinación de estrategia, administración de recursos y tecnología avanzada.

El núcleo del gameplay consiste en planificar cuidadosamente la ubicación de las torretas, mejorar las defensas y adaptarse a las distintas oleadas de enemigos. Cada tipo de unidad enemiga presenta características propias, por lo que el jugador deberá modificar constantemente su estrategia para responder de manera eficiente a cada amenaza.
A medida que se completan misiones, se obtienen créditos y tecnologías que permiten desbloquear nuevas torretas, habilidades y mejoras permanentes. Además, durante las partidas pueden producirse eventos dinámicos, como tormentas solares, lluvias de meteoritos o interferencias cósmicas, que alteran las condiciones del combate y obligan al jugador a replantear su estrategia en tiempo real.

El principal atractivo del juego es combinar una experiencia de estrategia accesible con una progresión constante y una alta rejugabilidad. La variedad de enemigos, mejoras, mapas y eventos hace que cada partida presente nuevos desafíos, incentivando al jugador a experimentar diferentes configuraciones defensivas para proteger el futuro de la humanidad.


### 2.4 Premisas del Videojuego
Las siguientes premisas establecen las reglas fundamentales del universo y del diseño de Defensa de Colonias Espaciales. Estas servirán como guía durante todo el desarrollo del proyecto.
1.	La supervivencia de la humanidad depende de las colonias espaciales. Cada colonia representa un refugio indispensable para la civilización, por lo que su defensa es la máxima prioridad.
2.	El jugador controla a ATLAS, una inteligencia artificial militar. El jugador no participa directamente en el combate, sino que coordina la defensa mediante la construcción de torretas, la administración de recursos y la investigación de nuevas tecnologías.
3.	El núcleo energético debe ser protegido en todo momento. Si los enemigos destruyen el núcleo de una colonia, la misión se considera perdida.
4.	La estrategia prevalece sobre la acción directa. El éxito depende de planificar correctamente la ubicación de las defensas, administrar los recursos disponibles y adaptarse a cada situación.
5.	Cada enemigo presenta un desafío diferente. Las unidades enemigas poseen habilidades y características propias, lo que obliga al jugador a modificar su estrategia a medida que avanza la partida.
6.	La progresión es permanente. Al completar misiones, el jugador obtiene recursos que permiten desbloquear nuevas tecnologías, mejorar las torretas y enfrentar desafíos de mayor dificultad.
7.	Los eventos dinámicos forman parte de cada partida. Fenómenos como tormentas solares, lluvias de meteoritos o interferencias cósmicas pueden alterar el desarrollo del combate, haciendo que cada partida sea diferente.
8.	La dificultad aumenta de forma gradual. A medida que el jugador avanza, aparecen enemigos más resistentes, nuevas mecánicas y niveles con mayor complejidad, incentivando el aprendizaje y la mejora constante.
9.	Cada decisión tiene consecuencias. La forma en que el jugador invierte sus recursos y organiza sus defensas influirá directamente en el resultado de cada misión


### 2.5 Condiciones del Desarrollo
El desarrollo de Defensa de Colonias Espaciales se realizará utilizando herramientas y metodologías que permitan organizar el trabajo de manera eficiente y cumplir con los objetivos académicos del proyecto.

**Herramientas de desarrollo**

•	Motor gráfico: Godot

•	Lenguaje de programación: GDScript y C#.

•	Editor de código:Godot.

•	Control de versiones: Git.

•	Repositorio remoto: GitHub para almacenar el código fuente y mantener un historial de cambios del proyecto.

•	Herramientas de diseño: Diagrams.net para diagramas y documentación, y herramientas de edición de imágenes según las necesidades del proyecto.

**Metodología de trabajo**

El proyecto seguirá una metodología de desarrollo iterativa e incremental. Cada etapa permitirá implementar, probar y mejorar las diferentes mecánicas del juego de forma progresiva. Se priorizará la creación de un prototipo funcional y, posteriormente, la incorporación de nuevas características, mejoras de jugabilidad y corrección de errores.

**Planificación y tiempos**

El desarrollo se organizará en etapas que incluirán:

•	Diseño y documentación del proyecto.

•	Desarrollo de las mecánicas principales.

•	Implementación de la interfaz de usuario y sistemas de progresión.

•	Integración de recursos gráficos y sonoros.

•	Pruebas, balance del juego y corrección de errores.

•	Preparación de la versión final para su presentación.

**Limitaciones de hardware y software**

El proyecto estará orientado a computadoras personales con sistema operativo Windows. Se buscará que el juego funcione correctamente en equipos de gama media, evitando un consumo excesivo de recursos. Asimismo, se utilizarán modelos 3D, efectos visuales y sonidos optimizados para mantener un rendimiento estable durante las partidas.
Al tratarse de un proyecto académico desarrollado por un único integrante, el alcance estará limitado a un conjunto de mecánicas y contenidos que puedan implementarse dentro del tiempo disponible, priorizando la calidad y estabilidad del producto final sobre la cantidad de contenido.


### 2.6 Alcance del proyecto
El proyecto tendrá como resultado un Vertical Slice completamente funcional de Defensa de Colonias Espaciales. La entrega representará una versión reducida del videojuego final, pero incluirá todas las mecánicas principales necesarias para demostrar la experiencia de juego propuesta.

La versión entregable incluirá:

•	Menú principal con opciones básicas de navegación.

•	Tutorial o nivel inicial para introducir las mecánicas fundamentales.

•	Sistema de construcción y mejora de torretas.

•	Diferentes tipos de enemigos con comportamientos propios.

•	Sistema de oleadas con dificultad progresiva.

•	Administración de recursos para construir y mejorar defensas.

•	Eventos dinámicos que modifiquen el desarrollo de la partida.

•	Interfaz de usuario funcional con indicadores de recursos, vida del núcleo y progreso de las oleadas.

•	Sistema de victoria y derrota.

•	Efectos visuales y sonoros básicos que acompañen la experiencia de juego.

El proyecto no incluirá todas las colonias, enemigos, tecnologías, mapas ni contenidos previstos para una versión comercial completa. Estos elementos quedarán planteados como posibles ampliaciones futuras.

El objetivo es entregar un producto estable y completamente jugable que demuestre las mecánicas principales, la identidad visual y la propuesta de diseño del videojuego, cumpliendo con los objetivos académicos del proyecto.

---

## 3. Diseño Detallado del Juego

### 3.1 Elementos del Juego
Jugador (ATLAS)
El jugador asume el control de ATLAS (Autonomous Tactical Logistic And Security System), una inteligencia artificial militar encargada de coordinar la defensa de las colonias espaciales. Su función consiste en construir y mejorar torretas, administrar recursos y desarrollar estrategias para detener las invasiones enemigas.
Núcleo Energético
Es el objetivo principal que debe protegerse durante cada misión. Representa la fuente de energía de la colonia. Si su vida llega a cero, la misión finaliza con una derrota.
Torretas Defensivas
Las torretas constituyen la principal herramienta defensiva del jugador. Cada una posee características específicas, como daño, alcance, velocidad de ataque o efectos especiales. Pueden construirse en puntos determinados del mapa y mejorarse utilizando los recursos obtenidos durante la partida.
Ejemplos de torretas:
•	Torreta Láser: alta velocidad de disparo y daño constante.
•	Torreta de Misiles: gran daño y largo alcance.
•	Torreta de Plasma: ataques de área que afectan a múltiples enemigos.
Enemigos
Los enemigos pertenecen a la raza extraterrestre Vorak e intentan destruir el núcleo energético de cada colonia. Cada tipo presenta diferentes atributos que obligan al jugador a adaptar su estrategia.
Tipos de enemigos:
•	Exploradores: rápidos y con poca resistencia.
•	Guerreros Alienígenas: enemigos equilibrados.
•	Tanques Biomecánicos: muy resistentes pero lentos.
•	Naves Escudadas: poseen escudos que absorben daño.
•	Saboteadores: pueden desactivar torretas temporalmente.
•	Jefes Finales: enemigos de gran tamaño con múltiples fases y habilidades especiales.
Recursos
Durante las partidas el jugador administra diferentes recursos:
•	Energía: utilizada para construir nuevas torretas y realizar mejoras.
•	Créditos Galácticos: obtenidos al completar misiones y empleados para desbloquear tecnologías y mejoras permanentes.
Power-Ups
Son habilidades especiales de uso temporal que ayudan al jugador en situaciones críticas.
Ejemplos:
•	Bombardeo Orbital.
•	Congelación Temporal.
•	Sobrecarga Energética.
•	Escudo de Emergencia.
•	Tormenta Electromagnética.
Eventos Dinámicos
Son sucesos aleatorios que modifican temporalmente las condiciones del combate y obligan al jugador a adaptar su estrategia.
Ejemplos:
•	Tormenta Solar.
•	Lluvia de Meteoritos.
•	Interferencia Cósmica.
•	Portal Inestable.
•	Eclipse Galáctico.
Interfaz de Usuario (HUD)
La interfaz proporciona toda la información necesaria durante la partida, incluyendo:
•	Vida del núcleo energético.
•	Recursos disponibles.
•	Cantidad de oleadas restantes.
•	Estado de las torretas.
•	Botones de construcción y mejora.
•	Indicadores de victoria o derrota.


### 3.2 Reglas
Las siguientes reglas determinan el funcionamiento del juego y establecen las condiciones bajo las cuales el jugador puede ganar o perder una partida.
Reglas generales
•	El objetivo principal del jugador es proteger el núcleo energético de la colonia durante toda la misión.
•	Los enemigos avanzan siguiendo una ruta predeterminada hasta llegar al núcleo energético.
•	El jugador no controla un personaje de forma directa; todas sus acciones consisten en construir, mejorar y administrar las defensas de la colonia.
•	Las torretas solo pueden construirse en los puntos habilitados del mapa.
•	Cada torreta posee un costo de construcción en energía y características propias de alcance, daño y velocidad de ataque.
•	Una torreta solo puede atacar enemigos que se encuentren dentro de su radio de alcance.
•	Las mejoras de las torretas requieren recursos y aumentan sus estadísticas o desbloquean nuevas habilidades.
•	Los recursos disponibles son limitados y deben administrarse estratégicamente durante toda la partida.
Reglas de las oleadas
•	Cada nivel está compuesto por una cantidad determinada de oleadas de enemigos.
•	La siguiente oleada comienza automáticamente después de un tiempo de preparación o cuando la anterior ha sido derrotada.
•	Cada nueva oleada incrementa la dificultad mediante enemigos más numerosos o resistentes.
•	Algunos niveles incluyen mini-jefes o jefes finales que representan un desafío mayor.
Reglas de los enemigos
•	Cada tipo de enemigo posee velocidad, resistencia y habilidades diferentes.
•	Algunos enemigos pueden tener escudos, alta velocidad o la capacidad de desactivar temporalmente las torretas.
•	Cuando un enemigo alcanza el núcleo energético, este pierde puntos de vida.
•	Al destruir enemigos, el jugador obtiene energía y créditos para continuar fortaleciendo sus defensas.
Reglas de los eventos dinámicos
•	Durante una partida pueden activarse eventos especiales de forma aleatoria.
•	Estos eventos pueden beneficiar o perjudicar al jugador.
•	Los eventos tienen una duración limitada y finalizan automáticamente.
Reglas de progresión
•	Al completar una misión, el jugador recibe créditos galácticos como recompensa.
•	Los créditos permiten desbloquear nuevas tecnologías, mejoras permanentes y torretas más avanzadas.
•	Las mejoras permanentes se conservan para las siguientes misiones.
Condiciones de victoria
El jugador gana la partida cuando:
•	Sobrevive a todas las oleadas del nivel.
•	El núcleo energético permanece operativo al finalizar la última oleada.
Condiciones de derrota
El jugador pierde la partida cuando:
•	La vida del núcleo energético llega a cero.
•	No logra detener la invasión antes de que los enemigos destruyan la colonia.
Restricciones del jugador
•	No es posible construir torretas fuera de las zonas permitidas.
•	No pueden realizarse mejoras si no se dispone de los recursos necesarios.
•	Una vez iniciada una oleada, el jugador deberá administrar sus recursos y defensas para responder a la amenaza.
•	El jugador deberá adaptar continuamente su estrategia según el tipo de enemigos y los eventos que aparezcan durante la misión.


### 3.3 Descripción de una sesión de juego
Una sesión de juego comienza cuando el jugador inicia Defensa de Colonias Espaciales y accede al menú principal. Desde allí puede comenzar una nueva partida, acceder a las opciones del juego o salir de la aplicación.
Al seleccionar Jugar, el jugador elige una colonia espacial disponible para defender. Antes de iniciar la misión, puede consultar información sobre el nivel, como la cantidad de oleadas, los tipos de enemigos que aparecerán y las tecnologías desbloqueadas.
Una vez iniciada la misión, el jugador recibe una cantidad inicial de energía para construir las primeras torretas defensivas. Durante un breve período de preparación, analiza el mapa y decide estratégicamente dónde colocar sus defensas antes de que comience la primera oleada.
Cuando inicia el combate, los enemigos aparecen siguiendo rutas predeterminadas con el objetivo de alcanzar el núcleo energético de la colonia. Las torretas atacan automáticamente a los enemigos que ingresan en su radio de alcance, mientras el jugador observa el desarrollo del combate y administra los recursos obtenidos al destruir enemigos.
Entre oleadas, o cuando dispone de recursos suficientes, el jugador puede construir nuevas torretas, mejorar las existentes o modificar su estrategia para prepararse para enemigos más fuertes. Durante la partida también pueden activarse eventos dinámicos, como tormentas solares o lluvias de meteoritos, que obligan al jugador a adaptar rápidamente su planificación.
A medida que avanza la misión, las oleadas aumentan su dificultad con la aparición de nuevos tipos de enemigos, unidades más resistentes y, en los niveles avanzados, jefes con habilidades especiales.
La partida finaliza de una de las siguientes maneras:
•	Victoria: el jugador consigue resistir todas las oleadas y mantiene el núcleo energético con vida. Como recompensa, obtiene créditos galácticos que puede utilizar para desbloquear nuevas tecnologías y mejoras permanentes.
•	Derrota: los enemigos logran destruir el núcleo energético antes de finalizar la misión. En este caso, el jugador puede volver a intentarlo aplicando una estrategia diferente.
Al finalizar la partida, el jugador regresa al menú de progreso, donde puede invertir las recompensas obtenidas, seleccionar una nueva misión o repetir la anterior con el objetivo de mejorar su desempeño.


### 3.4 Estética y Experiencia del Jugador
Defensa de Colonias Espaciales busca ofrecer una experiencia estratégica, desafiante y envolvente, donde el jugador sienta que cada decisión puede determinar el destino de las últimas colonias humanas. La ambientación de ciencia ficción, combinada con una progresión constante y una dificultad creciente, pretende mantener el interés del jugador durante toda la partida.
Las principales respuestas estéticas y emocionales que se buscan generar son:
Desafío
El jugador deberá analizar continuamente la situación del campo de batalla para decidir dónde construir nuevas torretas, cuáles mejorar y cómo administrar los recursos disponibles. La aparición de enemigos con habilidades diferentes y el aumento progresivo de la dificultad mantendrán una sensación constante de reto.
Tensión
Cada oleada incrementará la presión sobre las defensas de la colonia. La posibilidad de que el núcleo energético sea destruido y la aparición de eventos dinámicos inesperados obligarán al jugador a reaccionar rápidamente y adaptar su estrategia en tiempo real.
Satisfacción
Superar una oleada difícil, derrotar a un jefe o completar una misión después de una planificación exitosa generará una sensación de logro. Asimismo, desbloquear nuevas tecnologías y mejorar las torretas reforzará la percepción de progreso y recompensará el esfuerzo del jugador.
Curiosidad
La incorporación gradual de nuevos enemigos, tecnologías y mejoras incentivará al jugador a experimentar con diferentes combinaciones de torretas y estrategias para descubrir cuáles resultan más efectivas en cada situación.
Rejugabilidad
Cada partida ofrecerá una experiencia diferente gracias a la combinación de distintos tipos de enemigos, eventos dinámicos, mejoras disponibles y decisiones estratégicas del jugador. Esto fomentará volver a jugar para probar nuevas tácticas y obtener mejores resultados.
Inmersión
La ambientación futurista, los efectos visuales de los disparos y explosiones, la música de ciencia ficción y los efectos sonoros del combate buscarán transmitir la sensación de participar en una guerra espacial donde la supervivencia de la humanidad depende de las decisiones del jugador.
En conjunto, estos elementos pretenden ofrecer una experiencia estratégica accesible para nuevos jugadores, pero con suficiente profundidad para mantener el interés de quienes buscan optimizar sus tácticas y superar desafíos cada vez más complejos


---

## 4. Arte, Audio y Bocetos
<img width="925" height="1007" alt="image" src="https://github.com/user-attachments/assets/a1bcd2be-a4ea-4dab-aac2-64d780ca8006" />
Estilo Visual y Sonoro: 
Defensa de Colonias Espaciales adoptará un estilo artístico con una estética futurista inspirada en la ciencia ficción. Se utilizarán modelos de baja complejidad geométrica y texturas simples, lo que permitirá un buen rendimiento sin perder una identidad visual atractiva.
La paleta de colores combinará tonos oscuros para representar el espacio exterior con colores brillantes y llamativos que facilitarán la identificación de los distintos elementos del juego:
•	Azul y cian: tecnología humana, energía y torretas láser.
•	Rojo y naranja: explosiones, alertas y torretas de misiles.
•	Violeta: armas de plasma y tecnologías avanzadas.
•	Verde: interfaces, mejoras y elementos interactivos.
•	Grises y blancos: estructuras de las colonias espaciales.
•	Negro y azul oscuro: fondo espacial, nebulosas y sectores de la galaxia.
Cada colonia espacial tendrá una identidad visual propia mediante variaciones en el entorno, la iluminación y los detalles ambientales, permitiendo que cada escenario resulte fácilmente reconocible.
Los enemigos de la raza Vorak presentarán diseños diferenciados según su función dentro del combate. Las unidades rápidas tendrán una apariencia ligera y ágil, mientras que los enemigos más resistentes serán de mayor tamaño y contarán con una estética más intimidante. Los jefes finales destacarán por su escala, efectos visuales y animaciones especiales.
La interfaz de usuario será minimalista y clara, mostrando únicamente la información necesaria durante la partida: recursos disponibles, vida del núcleo energético, oleadas restantes, mejoras activas y opciones de construcción.
Estilo Sonoro
El apartado sonoro buscará reforzar la ambientación de una guerra espacial y proporcionar información al jugador durante la partida.
La música estará compuesta por temas instrumentales de ciencia ficción con elementos electrónicos y orquestales. Durante los momentos de preparación tendrá un ritmo tranquilo, mientras que aumentará su intensidad conforme avancen las oleadas y aparezcan enemigos más peligrosos o jefes finales.
Los efectos de sonido permitirán identificar fácilmente las acciones del juego. Cada tipo de torreta contará con disparos característicos, las explosiones tendrán distintas intensidades según el enemigo destruido y los eventos especiales dispondrán de efectos propios que alertarán al jugador de cambios importantes en el campo de batalla.
Asimismo, la interfaz incorporará sonidos para confirmar acciones como construir o mejorar torretas, recibir recursos, completar una misión o sufrir la destrucción del núcleo energético, contribuyendo a una experiencia más inmersiva y satisfactoria.



