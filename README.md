# FiveM Security Detailing Job for QBCore

This script adds a **Security Detailing Job** to your FiveM server using the QBCore framework. Players can take the job from NPCs and perform tasks such as patrolling areas, checking cameras, responding to alarms, and managing security details at various locations like businesses, private properties, or public events.

## Features

- **Security NPCs**: NPCs will offer security jobs to players. Players can approach them to start the job.
- **Patrol Areas**: Players are assigned to random patrol routes at designated locations to ensure security.
- **Alarm Responses**: Players will respond to random security alarms that trigger at specific locations.
- **Security Vehicles**: Players are given security vehicles to help with patrolling or responding to incidents.
- **Job Integration**: Smooth integration with QBCore's job system, allowing seamless transitions between different roles.

## Installation

1. **Download the Script**:
   - Download the `qb-security-detailing.lua` script and place it inside the `resources/[your_resource_folder]` directory of your server.

2. **Start the Script**:
   - In your `server.cfg`, add `ensure qb-security-detailing` to ensure the script starts when the server boots.

3. **Add Job to QB-Core**:
   - Open the `qb-core` database and add the Security job (or modify it based on your requirements):
     ```lua
     QBCore.Functions.CreateJob('security', 'Security', 'A civilian security detail job.')
     ```

4. **Add NPCs**:
   - Add NPCs to your server where players can receive the security detail job.
   - You can modify the NPC locations or appearance by adjusting the coordinates and model.

5. **Configure Patrol Points and Alarm Locations**:
   - Modify `Config.PatrolPoints` and `Config.AlarmLocations` with your own coordinates where you want players to patrol or respond to incidents.

## How to Use

1. **Accept Security Jobs**:
   - Players can approach designated NPCs (like "Officer Tom" or "Mrs. Kline") to start a security detail job. Once hired, they will be given a patrol task or assigned to monitor a location.

2. **Patrol Areas**:
   - Players use the `/patrol` command to patrol assigned locations. They are expected to monitor these areas for any security breaches.

3. **Respond to Alarms**:
   - Players can use the `/respondalarm` command to respond to security breaches triggered by an alarm at a random location.

4. **Security Vehicles**:
   - Players will be given a security vehicle when they accept the job, allowing them to travel to different locations quickly.

## Compatibility

This script works with the **QBCore Framework** and is designed to be used in a civilian roleplay environment. You can easily adjust patrol routes, alarm locations, and NPCs based on your server's needs.

## License

This script is free to use and modify, but crediting the author is appreciated when distributing or using this script publicly.

## Credits

- **Script Creator**: [CrypticTM]
- **QBCore Framework**: Developed by **QBCore**.
