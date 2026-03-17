# 🚂 [Project Name: 3 Days To Die]

![Godot Engine](https://img.shields.io/badge/GODOT-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)
![GDScript](https://img.shields.io/badge/GDScript-%23FFFFFF.svg?style=for-the-badge&logo=godot-engine)

> **A branching narrative murder-mystery built in Godot 4, featuring custom asynchronous dialogue parsing and robust state management.**

[Insert a high-quality GIF here showing the dialogue system in action, specifically the text effects or a branching choice]

## 📖 The Hook

Set in the colonized Republic of Songhai, a disgraced detective has three days to solve the murder of a secret police officer aboard a moving train. With a suspect pool ranging from a corrupted corporate Automata to a bitter tribal bodyguard, you must navigate complex branching dialogues to find the killer—or risk being framed for the crime yourself.

## 🛠️ Technical Architecture

This project was built to showcase advanced UI/UX handling and backend logic separation in Godot. Rather than relying on out-of-the-box engine constraints, I engineered custom solutions for narrative flow:

### Custom Asynchronous Dialogue Processing

* **Look-Ahead Parsing:** Engineered a "scout" architecture for the dialogue skip system. The engine asynchronously fetches and evaluates upcoming dialogue nodes in the background, breaking loops precisely before state-mutating commands or end-of-file traps to prevent UI crashes.
* **Decoupled Presentation Layer:** Separated the backend dialogue data stream from the frontend visual rendering (BBCode effects, balloons). Visual effects like `[shake]` run independently of the core state machine.

### Scalable State Management

* **Global GameStates:** Built a centralized dictionary-based tracking system to monitor player choices, inventory (e.g., Godswill's stolen badge and locket), and narrative checkpoints (like the Scream Investigation Scene).
* **Dynamic Branching:** The narrative dynamically routes based on past interactions, ensuring seamless transitions without hardcoding scene dependencies.

## 🕹️ Gameplay Features

* **Interrogation Mechanics:** Question a diverse cast of 7 unique suspects, each with conflicting motives and hidden ties to the colonial government or the local rebellion.
* **Ticking Clock:** A strict 3-day in-game time limit to gather evidence before the train reaches the coastal town of Eadricsburh.

## 📂 Repository Structure

* `/dialogue`: Contains all `.dialogue` resource files and the custom branching logic.
* `/scripts/autoloads`: Houses the `GameStates.gd` and global managers.
* `/scenes/UI`: Decoupled visual rendering components for the dialogue balloon and player choices.
* 
