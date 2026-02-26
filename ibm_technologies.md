---
title: "IBM Technologies Reference"
nav_order: 21
---

# IBM Technologies Reference

A reference guide to all IBM products and platforms featured in this book, organised by the integration plane or architectural area in which they operate.

---

## Data Plane — Federated Access & Virtualisation

**[IBM watsonx.data](https://www.ibm.com/products/watsonx-data)**
An open lakehouse platform and federated query engine (built on Presto/Trino) that allows analytical workloads to access data in place across heterogeneous sources without physical consolidation.

**[IBM Cloud Pak for Data](https://www.ibm.com/products/cloud-pak-for-data)**
A unified data and AI platform that provides the operational infrastructure and integration framework for capabilities like data virtualisation and governance.

**[IBM Data Virtualization Manager](https://www.ibm.com/products/data-virtualization-manager-for-zos)**
Provides enterprise data virtualisation across a broad range of legacy source systems, presenting virtual views through a unified SQL interface without moving the data.

**[IBM Data Gate for watsonx](https://www.ibm.com/products/data-gate-for-watsonx)**
A governed, real-time federation interface that allows IBM watsonx.data's query engine to execute queries directly against data held on IBM Z mainframe systems.

**[IBM Analytics Engine](https://www.ibm.com/products/analytics-engine)**
A managed Apache Spark service that provides in-place batch computation for federated analytics workloads.

**[IBM StreamSets](https://www.ibm.com/products/streamsets)**
A governed data pipeline and Change Data Capture platform that extracts state changes from legacy and mainframe source systems — including those without native event streaming interfaces — and delivers them as governed CDC events to the enterprise event fabric.

---

## Application Integration Plane — APIs & Mediation

**[IBM Cloud Pak for Integration](https://www.ibm.com/products/cloud-pak-for-integration)**
An enterprise integration platform deployed on Red Hat OpenShift that unifies API management, event streaming, and application integration into a coherent integration fabric.

**[IBM API Connect](https://www.ibm.com/products/api-connect)**
The management and governance layer for the Application Integration Plane, providing API lifecycle management, developer portals, and policy management to govern inter-application communication.

**[IBM DataPower Gateway](https://www.ibm.com/products/datapower-gateway)**
The high-performance runtime policy enforcement infrastructure that applies security policies, data masking, and content filtering for APIs exposing sensitive data.

**[IBM App Connect (and App Connect Enterprise)](https://www.ibm.com/products/app-connect)**
An integration runtime and mediation layer equipped with pre-built connectors to expose legacy systems, SaaS applications, and OT networks through governed API interfaces.

**[IBM webMethods Integration](https://www.ibm.com/products/webmethods-integration)**
An enterprise B2B and application integration platform providing EDI, partner onboarding, and broad protocol connectivity for integrating external trading partners and legacy packaged applications into the governed integration fabric.

---

## Event Plane — Streaming & Messaging

**[IBM Event Streams](https://www.ibm.com/products/event-streams)**
An enterprise distribution of Apache Kafka that provides a durable, high-throughput event backbone for propagating state changes as lightweight notifications.

**[IBM MQ](https://www.ibm.com/products/mq)**
An enterprise message broker providing reliable, ordered, exactly-once delivery semantics for transactional integration patterns.

**[IBM Event Automation](https://www.ibm.com/products/event-automation)**
A unified platform that brings together IBM Event Streams, IBM Event Endpoint Management (for event portal and schema registry governance), and IBM Event Processing (for real-time event stream transformation).

**[IBM InfoSphere Data Replication](https://www.ibm.com/products/infosphere-data-replication)**
Provides Change Data Capture (CDC) capabilities to extract state changes from source databases without modifying the applications.

---

## Control Plane — Governance, Observability, FinOps & Audit

**[IBM Knowledge Catalog](https://www.ibm.com/products/knowledge-catalog)**
The core data intelligence layer that maintains data classification metadata, business glossaries, access policies, and OpenLineage tracking to enforce governance at the point of access.

**[IBM Guardium](https://www.ibm.com/products/guardium)**
An enterprise data security and compliance platform that monitors data access at the database layer, recording every query to provide a tamper-evident audit trail.

**[IBM Guardium Key Lifecycle Manager](https://www.ibm.com/products/guardium-key-lifecycle-manager)**
Provides centralised management of encryption keys for data at rest.

**[IBM Instana](https://www.ibm.com/products/instana)**
A full-stack observability platform providing AI-powered anomaly detection, distributed tracing, and automatic instrumentation to monitor the health and performance of the integration fabric.

**[IBM Turbonomic](https://www.ibm.com/products/turbonomic)**
An application resource management platform that provides AI-driven capacity management and workload optimisation, supporting FinOps disciplines by preventing over-provisioning.

**[IBM OpenPages](https://www.ibm.com/products/openpages)**
An integrated risk and governance management platform that provides the business process layer and regulatory workflows for data access requests.

---

## Security, Sovereignty & Identity

**[IBM Sovereign Core](https://www.ibm.com/products/sovereign-core)**
A software stack built on Red Hat OpenShift that makes sovereignty a property of the software environment, featuring a customer-operated control plane and automated sovereignty controls.

**[IBM Hyper Protect Virtual Servers](https://www.ibm.com/products/hyper-protect-virtual-servers) & [IBM Hyper Protect Crypto Services](https://www.ibm.com/products/hyper-protect-crypto)**
Provides confidential computing enclaves to protect data in use during processing, and Hardware Security Module (HSM)-backed sovereign key management.

**[IBM Security Verify](https://www.ibm.com/products/verify)**
An enterprise identity and access management platform that provides Attribute-Based Access Control (ABAC) and identity federation across multi-cloud environments.

**[IBM Key Protect](https://www.ibm.com/products/key-protect)**
Provides cloud-based key management capabilities using bring-your-own-key or hold-your-own-key models.

**[IBM Cloud Pak for Security](https://www.ibm.com/products/cloud-pak-for-security)**
Provides a unified threat management console to tie together identity, policy enforcement, data monitoring, and threat detection.

**[IBM QRadar](https://www.ibm.com/products/qradar-siem)**
A Security Information and Event Management (SIEM) platform that correlates security events from across the integration estate for centralised threat detection and response.

**[IBM Quantum Safe](https://www.ibm.com/quantum/quantum-safe)**
Tools to discover cryptographic vulnerabilities across the integration estate and map out dependencies for a post-quantum migration.

**[HashiCorp Terraform](https://www.hashicorp.com/en/products/terraform)**
An infrastructure-as-code provisioning tool used to declare, version, and consistently deploy sovereign zone infrastructure across cloud and on-premises environments, ensuring the DR twin topology is identical to the primary deployment.

**[HashiCorp Vault](https://www.hashicorp.com/en/products/vault)**
A dynamic secrets management platform that eliminates static credential proliferation by issuing short-lived, scoped credentials to workloads on demand, with a full audit trail of every secret issuance.

---

## Compute, Infrastructure & Edge

**[Red Hat OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift) (and MicroShift)**
The foundational enterprise Kubernetes container platform enabling portable deployment across on-premises, cloud, and edge environments.

**[Red Hat OpenShift Service Mesh](https://www.redhat.com/en/technologies/cloud-computing/openshift/what-is-openshift-service-mesh)**
Provides the intra-cluster communication layer, enforcing mutual TLS and traffic management between microservices.

**[Red Hat Advanced Cluster Management](https://www.redhat.com/en/technologies/management/advanced-cluster-management)**
Enforces consistent configuration policies across a fleet of sovereign multi-cloud clusters.

**[Red Hat Ansible Automation Platform](https://www.redhat.com/en/technologies/management/ansible)**
Provides the execution environment for automated disaster recovery runbooks.

**[IBM Cloud Satellite](https://www.ibm.com/products/satellite)**
Extends IBM Cloud services to on-premises, edge, and other public cloud locations, enabling local execution of workloads with a centralised management plane.

**[IBM Edge Application Manager](https://www.ibm.com/products/edge-application-manager)**
Provides the central management plane for configuring and monitoring remote edge deployments.

**[IBM Z](https://www.ibm.com/products/z) and [LinuxONE](https://www.ibm.com/products/linuxone)**
Mainframe infrastructure providing hardware-enforced isolation (Secure Execution) and transactional processing.

**[IBM Cloud for Government](https://www.ibm.com/products/cloud/government) / [IBM Financial Services Cloud](https://www.ibm.com/products/cloud/financial-services)**
Regulated sovereign cloud environments with built-in controls mapping to specific public sector and financial industry compliance frameworks.

---

## AI & Machine Learning

**[IBM watsonx.ai](https://www.ibm.com/products/watsonx-ai)**
The AI development and deployment platform used for regional inference serving and federated machine learning training coordination.

**[IBM watsonx.governance](https://www.ibm.com/products/watsonx-governance)**
Provides the AI governance layer to track model lineage, monitor agentic AI data access, and maintain explainability documentation required by frameworks like the EU AI Act.
