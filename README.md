# 🚂 [Project Name: 3 Days To Die]

![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)
![GDScript](https://img.shields.io/badge/GDScript-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)

> **A branching narrative murder-mystery built in Godot 4, featuring custom asynchronous dialogue parsing and robust state management.**

## 📖 The Hook
[span_0](start_span)[span_1](start_span)Set in the colonized Republic of Songhai, a disgraced detective has three days to solve the murder of a secret police officer aboard a moving train[span_0](end_span)[span_1](end_span). [span_2](start_span)[span_3](start_span)[span_4](start_span)[span_5](start_span)[span_6](start_span)With a suspect pool ranging from a corrupted corporate Automata to a bitter tribal bodyguard, you must navigate complex branching dialogues to find the killer—or risk being framed for the crime yourself[span_2](end_span)[span_3](end_span)[span_4](end_span)[span_5](end_span)[span_6](end_span).

## 🛠️ Technical Architecture

This project was built to showcase advanced UI/UX handling and backend logic separation in Godot. Rather than relying on out-of-the-box engine constraints, I engineered custom solutions for narrative flow:

### Custom Asynchronous Dialogue Processing
* **Look-Ahead Parsing:** Engineered a "scout" architecture for the dialogue skip system. The engine asynchronously fetches and evaluates upcoming dialogue nodes in the background, breaking loops precisely before state-mutating commands or end-of-file traps to prevent UI crashes.
* **Decoupled Presentation Layer:** Separated the backend dialogue data stream from the frontend visual rendering (BBCode effects, balloons). Visual effects like `[shake]` run independently of the core state machine.

### Scalable State Management
* **[span_7](start_span)Global GameStates:** Built a centralized dictionary-based tracking system to monitor player choices, inventory (e.g., Godswill's stolen badge and locket[span_7](end_span)), and narrative checkpoints (like the Scream Investigation Scene).
* **Dynamic Branching:** The narrative dynamically routes based on past interactions, ensuring seamless transitions without hardcoding scene dependencies.

## 🕹️ Gameplay Features
* **[span_8](start_span)[span_9](start_span)[span_10](start_span)[span_11](start_span)Interrogation Mechanics:** Question a diverse cast of 7 unique suspects, each with conflicting motives and hidden ties to the colonial government or the local rebellion[span_8](end_span)[span_9](end_span)[span_10](end_span)[span_11](end_span).
* **[span_12](start_span)[span_13](start_span)Ticking Clock:** A strict 3-day in-game time limit to gather evidence before the train reaches the coastal town of Eadricsburh[span_12](end_span)[span_13](end_span).

## 📂 Repository Structure
* `/dialogue`: Contains all `.dialogue` resource files and the custom branching logic.
* `/scripts/autoloads`: Houses the `GameStates.gd` and global managers.
* `/scenes/UI`: Decoupled visual rendering components for the dialogue balloon and playe
* r choices.
