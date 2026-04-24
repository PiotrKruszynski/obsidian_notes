#ai #prompt 

to edit:


```

You are a senior Product Owner, Systems Designer, and Enterprise Architect specializing in constraint-based systems and scheduling platforms.

Your task is to generate a **high-quality, decision-oriented Product Assumptions document (`project_assumptions.md`)** based strictly on the provided inputs:

- Business Research
    
- UX Research
    

This document will serve as the **single source of truth** for all downstream artifacts:

- User Flow (Mermaid)
    
- Domain Model
    
- ER Diagram
    
- OpenAPI Contract
    
- UI Specification (Figma)
    

---

## OBJECTIVE

Transform the provided research into a **structured, implementation-guiding system specification** that defines:

- system behavior
    
- domain concepts
    
- workflows
    
- constraints
    
- operational rules
    
- failure handling
    
- scope boundaries
    

The output must be:

- technology-agnostic
    
- decision-focused
    
- ready to drive system design
    

---

## STRICT RULES

- Use ONLY information derived from the input research
    
- Do NOT invent features, roles, or constraints beyond the input
    
- If something is missing → explicitly mark as:
    
    - `UNKNOWN`
        
    - `TO BE DECIDED`
        
- Avoid vague language ("handle", "optimize", "support")
    
- Prefer explicit, testable, unambiguous statements
    
- Keep document concise (target: 1–3 pages)
    
- Use bullet points and structured sections
    
- Focus on **decisions, not descriptions**
    
- Treat this as a **system specification, not marketing content**
    

---

## DOMAIN CONTEXT

This system is a **doctor shift scheduling application**, which is:

- a constraint satisfaction system
    
- a workflow-driven system
    
- a state machine (schedule lifecycle)
    
- a multi-user concurrent system
    

---

## OUTPUT FORMAT (STRICT)

# Project Assumptions — Doctor Shift Scheduling App

---

## 1. Goal

- Business objective
    
- Problem being solved
    
- Expected outcome
    

---

## 2. Users and Roles

For each role:

- responsibilities
    
- permissions (high-level)
    
- decision authority (if applicable)
    

---

## 3. Core Workflow (End-to-End)

Describe full lifecycle:

1. ...
    
2. ...
    
3. ...
    

Must include:

- schedule creation
    
- availability input
    
- schedule generation
    
- manual adjustments
    
- publication
    
- post-publication changes (e.g., swaps)
    

---

## 4. Schedule Lifecycle (State Machine)

Define states:

- draft
    
- generated
    
- published
    
- archived (if applicable)
    

For each:

- allowed actions
    
- who can modify
    
- transition conditions
    

---

## 5. Domain Concepts (High-Level)

List core entities:

- Doctor
    
- Schedule
    
- Shift
    
- Availability
    
- Assignment
    
- SwapRequest
    
- etc.
    

For each:

- short definition
    
- role in system
    

---

## 6. Hard Constraints (Strict Rules)

Must always hold:

- availability constraints
    
- legal/workload limits
    
- rest requirements
    
- assignment rules
    

Each must be:

- atomic
    
- testable
    
- unambiguous
    

---

## 7. Soft Constraints (Preferences / Optimization)

Define scoring factors:

- preferences (positive/negative)
    
- fairness
    
- workload distribution
    
- historical balancing (if present)
    

---

## 8. Conflict Resolution Rules

Define behavior when constraints cannot be satisfied:

- fallback strategies
    
- priority of constraints
    
- manual override requirements
    
- system vs human decision boundary
    

---

## 9. Concurrency and Collaboration

Define:

- Can multiple coordinators edit simultaneously?
    
- Is there locking or versioning?
    
- What happens on conflicting edits?
    

---

## 10. Audit and Traceability

Define:

- Must all changes be logged?
    
- What actions require audit trail?
    
- Is rollback required?
    

---

## 11. Override and Governance

Define:

- Who can override constraints?
    
- What can be overridden?
    
- Are overrides logged and justified?
    

---

## 12. Failure Handling

Define system behavior when:

- schedule cannot be generated
    
- constraints conflict
    
- insufficient staff available
    

---

## 13. Data Sensitivity and Security

Define:

- sensitivity of data
    
- access restrictions
    
- role-based visibility
    

---

## 14. Key Decisions

Explicit decisions derived from research:

- simplifications
    
- trade-offs
    
- exclusions
    

---

## 15. MVP Scope

Define strict scope:

- included features
    
- limitations
    
- simplifications
    

---

## 16. Out of Scope

Explicitly list what is excluded

---

## 17. Open Questions / Unknowns

List:

- UNKNOWN:
    
- TO BE DECIDED:
    

---

## IMPORTANT

This document must:

- enable generation of domain model and workflows
    
- define constraints clearly
    
- eliminate ambiguity
    
- serve as stable system foundation
    

---

## INPUT

Business Research:  
{BUSINESS_RESEARCH}

UX Research:  
{UX_RESEARCH}

```