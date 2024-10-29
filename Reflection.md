# Final Group Reflection on Tower Defense Project Development

## Group Reflection

Our journey in developing the Tower Defense project has provided profound insights into the realities of group software development, particularly in an academic setting. This reflection captures our key learnings and observations from both the prototype and final development phases.

### Team Dynamics and Project Management

1. **Expectation Management**
   - We learned that setting realistic expectations based on individual commitment levels is crucial
   - The initial approach of equal task division proved ineffective when participation levels varied significantly
   - Future projects would benefit from a more flexible, motivation-driven task allocation system

2. **Communication Challenges**
   - Despite attempts to establish regular communication channels and schedules, maintaining consistent interaction proved difficult
   - The importance of having clear, documented communication protocols became evident throughout the project

3. **Design Agreement and Documentation**
   - Initial design discussions lacked depth, with team members agreeing to proposals without thorough understanding
   - The absence of comprehensive UML diagrams and design documentation led to integration challenges
   - We learned that passive agreement doesn't equate to active understanding or commitment

### Technical Development Insights

1. **Abstract Development Approach**
   - The necessity of developing components abstractly when dependent components aren't ready
   - This approach, while challenging, proved valuable when integration finally occurred
   - The importance of flexible, well-structured code became evident during the integration phase

2. **Code Organization and Maintenance**
   - Dealing with abandoned or poorly structured code required significant effort
   - The importance of maintaining proper inheritance hierarchies and clear documentation
   - Experience gained in refactoring and reorganizing "spaghetti code" proved valuable

3. **Integration Challenges**
   - Components developed in isolation faced integration issues
   - The need for better component interface definitions and documentation
   - Learning to adapt and modify code to work with existing components

### Key Learnings for Future Projects

1. **Project Initialization**
   - Start with clear, documented agreements on:
     - Individual commitment levels
     - Design principles and architecture
     - Communication protocols
     - Code structure and organization standards

2. **Task Management**
   - Adopt a more flexible approach based on:
     - Individual motivation and availability
     - Clear communication of capabilities and limitations
     - Regular progress updates and redistribution of tasks as needed

3. **Documentation and Communication**
   - Implement comprehensive documentation practices:
     - Detailed UML diagrams before development
     - Clear component interfaces and interactions
     - Regular code review and documentation updates

### Conclusion

This project has been a valuable learning experience in understanding the complexities of group software development. The challenges we faced, particularly in team coordination and communication, have provided important lessons for future projects. While the final product may not have met all initial expectations, the learning outcomes in terms of project management, technical development, and team dynamics have been significant.

Moving forward, we recognize that successful group projects require:
- Clear and honest communication about commitment levels
- Comprehensive design documentation and agreement
- Flexible task allocation based on motivation and capability
- Regular code review and documentation practices
- Strong project management and coordination

These insights will be valuable for future software development projects, whether in academic or professional settings.









## Individual Reflections for the prototype

### [Team Member 1 Name]
[personal reflection on the development process, what you've learned, challenges faced, and any insights gained]

### [Team Member 2 Name]
[Space for Team Member 2's reflection]

### [Nagare Negishi, 🐶 , LevelManager]

As the team member responsible for the LevelManager component, my experience during this prototype development phase has been both challenging and enlightening:

- Abstract Framework Development: I successfully created an abstract framework for the LevelManager class. This process taught me the importance of designing flexible and scalable systems, even when other components are not yet available. It reinforced my understanding of object-oriented design principles and how to prepare for future integration.

- Adaptation and Integration: Due to the lack of implemented classes, I had to adapt my approach. I created a new class that utilized the spawner system created by another team member for the prototype. This experience highlighted the importance of flexibility in software development and the ability to work with existing code to achieve immediate goals.

- Communication Challenges: I realized the critical importance of clear and consistent communication in a team project. I attempted to establish a system of sharing design intentions and component interactions through GitLab issues. However, these efforts were not as successful as hoped, which impeded our ability to integrate different parts of the system effectively.

- Role Dynamics and Project Management: The animal role system didn't translate effectively to our project. This experience emphasized the importance of early alignment on expectations and consistent contributions from all team members in voluntary group settings.

### [Bruno Helbick, 😼, Towers]

Working on the Towers has been an interesting experience.

During the development of the first Tower, I faced challenges when adjustments were made to how certain systems operated, which required significant changes to how my towers functioned. Since my towers were initially designed around a different approach, this showed the importance of flexible design.

One of the main challenges was communication, as there were moments where it felt lacking across the team. My own communication was affected by personal circumstances, including a pretty bad period of sickness, which made it difficult to stay engaged and maintain consistent involvement. In hindsight, better communication on my part could have helped overcome some of these difficulties.

Overall, this experience has been eye-opening in terms of what’s needed to operate smoothly as a team. Teamwork is an area I’m keen to improve on in future projects, ensuring that I contribute not only in code but also in open discussions to help create a more effective and stress-free development process.

### [Brock Clarke, 🐰, Enemy logic and HUD]

As the Team memeber initially resposible for the Enenmy spawner/wave system it has been interesting to find out how to spawn multiple enemies off one instance of a path follow2D, This is a part of the game engine I lightly touched on in my first project and something i did initially find quite difficult,
and because of that it is the reason I opted for this task.

As we have had a bit of a lack of commuication towards the project I have also had a hand in implementing the map for the project and working on the HUD, the map was quite simple as I worked with Tilesets in my first project but linking up buttons from the HUD to other scripts within the project have proved to be a challenge, i look forawrd to learning more about how to effectivley implement these an imporve on my current work so far which will be looking more into signals.

Working as a team has also been quite enlightening as said by Nagare that animal system doesnt necessarily work as people fall into thier natural demanors. my role assigned has been the communicator/ facilitator while I dont think my communication has lacked there is certainly room for improvement with this and future projects

### [Angus Ng,  🦉]
As the team member responsible for ideating the game concept and developing the early prototype of the title screen, this phase has offered a mix of creative challenges and learning experiences:

Conceptual Development: Generating the initial idea required balancing creativity with feasibility. Crafting a compelling yet achievable concept pushed me to consider our team’s skill set and project timeline, encouraging me to focus on creating a solid foundation that everyone could build upon. This experience has been invaluable for learning how to align vision with practical execution.

Title Screen Prototype: Developing the title screen prototype allowed me to experiment with design and set the game's initial tone. It underscored the importance of first impressions, making me realize how critical even the smallest design elements are in drawing players in. It also required thinking ahead about how the title screen would integrate with the rest of the game’s visuals and user interface. This experience strengthened my understanding of the visual and interactive flow needed to engage users right from the start.

Challenges with Coordination and Communication: Due to some personal circumstances, I faced challenges in maintaining consistent communication, which impacted my ability to coordinate as effectively as I’d hoped. As with any project involving multiple roles, coordinating design ideas and integrating the title screen within the evolving structure was challenging. Clear communication became essential to ensure consistency in theme and functionality across different areas of development. In hindsight, establishing a more structured process for design feedback early on would have streamlined our collaboration.

Overall, this experience has emphasized the importance of both foundational vision and cross-functional collaboration. Moving forward, I hope to enhance my approach to design communication and maintain stronger team engagement to foster a cohesive user experience.