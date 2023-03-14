
## Architecture and Design
The architecture of a software system encompasses the set of key decisions about its overall organization. 

A well written architecture document is brief but reduces the amount of time it takes new programmers to a project to understand the code to feel able to make modifications and enhancements.

To document the architecture requires describing the decomposition of the system in their parts (high-level components) and the key behaviors and collaborations between them. 


### Domain model

The image below represents the entire Domain Model of this application:

![DomainModel](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T5/blob/main/images/DomainModel.png)

### Logical architecture
The purpose of this subsection is to document the high-level logical structure of the code (Logical View), using a UML diagram with logical packages, without the worry of allocating to components, processes or machines.

It can be beneficial to present the system both in a horizontal or vertical decomposition:
* horizontal decomposition may define layers and implementation concepts, such as the user interface, business logic and concepts; 
* vertical decomposition can define a hierarchy of subsystems that cover all layers of implementation.

The image below represents the Logical View of CineScope and all layers that we must implement on this application.

![LogicalView](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T5/blob/main/images/LogicalArchitecture.png)

### Physical architecture
The goal of this subsection is to document the high-level physical structure of the software system (machines, connections, software components installed, and their dependencies) using UML deployment diagrams (Deployment View) or component diagrams (Implementation View), separate or integrated, showing the physical structure of the system.

It should describe also the technologies considered and justify the selections made. Examples of technologies relevant for uni4all are, for example, frameworks for mobile applications (such as Flutter).

The image below represents the Physical architecture of the CineScope app.

![DeploymentView](https://github.com/FEUP-LEIC-ES-2022-23/2LEIC13T5/blob/main/images/PhysicalArchitecture.jpeg)



### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).

