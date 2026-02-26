---
title: "IBM Technologies Reference"
nav_order: 21
---

# IBM Technologies Reference

A reference guide to all IBM products and platforms featured in this book, organised by the integration plane or architectural area in which they operate.

---

## Data Plane — Federated Access & Virtualisation

**IBM watsonx.data**
An open lakehouse platform and federated query engine (built on Presto/Trino) that allows analytical workloads to access data in place across heterogeneous sources without physical consolidation.

**IBM Cloud Pak for Data**
A unified data and AI platform that provides the operational infrastructure and integration framework for capabilities like data virtualisation and governance.

**IBM Data Virtualization Manager**
Provides enterprise data virtualisation across a broad range of legacy source systems, presenting virtual views through a unified SQL interface without moving the data.

**IBM Data Gate for watsonx**
A governed, real-time federation interface that allows IBM watsonx.data's query engine to execute queries directly against data held on IBM Z mainframe systems.

**IBM Analytics Engine**
A managed Apache Spark service that provides in-place batch computation for federated analytics workloads.

---

## Application Integration Plane — APIs & Mediation

**IBM Cloud Pak for Integration**
An enterprise integration platform deployed on Red Hat OpenShift that unifies API management, event streaming, and application integration into a coherent integration fabric.

**IBM API Connect**
The management and governance layer for the Application Integration Plane, providing API lifecycle management, developer portals, and policy management to govern inter-application communication.

**IBM DataPower Gateway**
The high-performance runtime policy enforcement infrastructure that applies security policies, data masking, and content filtering for APIs exposing sensitive data.

**IBM App Connect (and App Connect Enterprise)**
An integration runtime and mediation layer equipped with pre-built connectors to expose legacy systems, SaaS applications, and OT networks through governed API interfaces.

---

## Event Plane — Streaming & Messaging

**IBM Event Streams**
An enterprise distribution of Apache Kafka that provides a durable, high-throughput event backbone for propagating state changes as lightweight notifications.

**IBM MQ**
An enterprise message broker providing reliable, ordered, exactly-once delivery semantics for transactional integration patterns.

**IBM Event Automation**
A unified platform that brings together IBM Event Streams, IBM Event Endpoint Management (for event portal and schema registry governance), and IBM Event Processing (for real-time event stream transformation).

**IBM InfoSphere Data Replication**
Provides Change Data Capture (CDC) capabilities to extract state changes from source databases without modifying the applications.

---

## Control Plane — Governance, Observability, FinOps & Audit

**IBM Knowledge Catalog**
The core data intelligence layer that maintains data classification metadata, business glossaries, access policies, and OpenLineage tracking to enforce governance at the point of access.

**IBM Guardium (and Guardium Insights)**
An enterprise data security and compliance platform that monitors data access at the database layer, recording every query to provide a tamper-evident audit trail.

**IBM Guardium Key Lifecycle Manager**
Provides centralised management of encryption keys for data at rest.

**IBM Instana**
A full-stack observability platform providing AI-powered anomaly detection, distributed tracing, and automatic instrumentation to monitor the health and performance of the integration fabric.

**IBM Turbonomic**
An application resource management platform that provides AI-driven capacity management and workload optimisation, supporting FinOps disciplines by preventing over-provisioning.

**IBM OpenPages**
An integrated risk and governance management platform that provides the business process layer and regulatory workflows for data access requests.

---

## Security, Sovereignty & Identity

**IBM Sovereign Core**
A software stack built on Red Hat OpenShift that makes sovereignty a property of the software environment, featuring a customer-operated control plane and automated sovereignty controls.

**IBM Hyper Protect (Virtual Servers & Crypto Services)**
Provides confidential computing enclaves to protect data in use during processing, and Hardware Security Module (HSM)-backed sovereign key management.

**IBM Security Verify**
An enterprise identity and access management platform that provides Attribute-Based Access Control (ABAC) and identity federation across multi-cloud environments.

**IBM Key Protect**
Provides cloud-based key management capabilities using bring-your-own-key or hold-your-own-key models.

**IBM Cloud Pak for Security**
Provides a unified threat management console to tie together identity, policy enforcement, data monitoring, and threat detection.

**IBM QRadar**
A Security Information and Event Management (SIEM) platform that correlates security events from across the integration estate for centralised threat detection and response.

**IBM Quantum Safe (Explorer & Advisor)**
Tools to discover cryptographic vulnerabilities across the integration estate and map out dependencies for a post-quantum migration.

---

## Compute, Infrastructure & Edge

**Red Hat OpenShift (and MicroShift)**
The foundational enterprise Kubernetes container platform enabling portable deployment across on-premises, cloud, and edge environments.

**Red Hat OpenShift Service Mesh**
Provides the intra-cluster communication layer, enforcing mutual TLS and traffic management between microservices.

**Red Hat Advanced Cluster Management**
Enforces consistent configuration policies across a fleet of sovereign multi-cloud clusters.

**Red Hat Ansible Automation Platform**
Provides the execution environment for automated disaster recovery runbooks.

**IBM Cloud Satellite**
Extends IBM Cloud services to on-premises, edge, and other public cloud locations, enabling local execution of workloads with a centralised management plane.

**IBM Edge Application Manager**
Provides the central management plane for configuring and monitoring remote edge deployments.

**IBM Z and LinuxONE**
Mainframe infrastructure providing hardware-enforced isolation (Secure Execution) and transactional processing.

**IBM Cloud for Government / IBM Financial Services Cloud**
Regulated sovereign cloud environments with built-in controls mapping to specific public sector and financial industry compliance frameworks.

---

## AI & Machine Learning

**IBM watsonx.ai**
The AI development and deployment platform used for regional inference serving and federated machine learning training coordination.

**IBM watsonx.governance**
Provides the AI governance layer to track model lineage, monitor agentic AI data access, and maintain explainability documentation required by frameworks like the EU AI Act.
