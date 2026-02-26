---
title: "Open Source Technologies Reference"
nav_order: 22
---

# Open Source Technologies Reference

A reference guide to the open source projects, frameworks, and open standards featured in this book, organised by the integration plane or architectural area in which they operate. IBM enterprise products are built on many of these foundations — they are listed separately on the [IBM Technologies Reference](ibm_technologies) page.

---

## Data Plane — Federated Access & Virtualisation

**[Trino](https://trino.io) (formerly Presto)**
A distributed federated SQL query engine that executes analytical queries across heterogeneous data sources — object stores, relational databases, data lakes — without consolidating the data. Forms the query engine foundation of IBM watsonx.data.

**[Apache Iceberg](https://iceberg.apache.org)**
An open table format for large analytical datasets that provides multi-engine access, partition evolution, time-travel queries, and ACID transactions without format-specific replication. The primary open table format used in sovereign lakehouse architectures throughout this book.

**[Apache Arrow](https://arrow.apache.org)**
An in-memory columnar data format that enables high-performance analytical processing and zero-copy data interchange between query engines, avoiding serialisation overhead when data must be passed between systems.

**[Apache Parquet](https://parquet.apache.org)**
An open columnar storage file format optimised for analytical workloads. Used alongside Apache Iceberg as the physical storage format for sovereign lakehouse data assets.

**[Delta Lake](https://delta.io)**
An open-source storage layer that adds ACID transactions, scalable metadata handling, and data versioning to data lakes, providing an alternative open table format to Apache Iceberg.

**[Apache Atlas](https://atlas.apache.org)**
An open metadata repository and governance framework providing data lineage tracking, classification, and business glossary capabilities for Hadoop-adjacent data estates.

**[Apache Hadoop](https://hadoop.apache.org)**
A distributed processing framework providing the foundational distributed storage and computation model from which the modern lakehouse architecture evolved.

---

## Event Plane — Streaming & Messaging

**[Apache Kafka](https://kafka.apache.org)**
The de facto open source standard for enterprise event streaming. Provides a durable, high-throughput, distributed log for propagating state changes as lightweight event notifications across the integration estate. IBM Event Streams is an enterprise distribution of Apache Kafka.

**[Apache Avro](https://avro.apache.org)**
A compact, binary data serialisation format used for event schema governance. Avro schemas are stored in a schema registry, ensuring that producers and consumers share a common, versioned understanding of event structure.

**[MirrorMaker 2](https://kafka.apache.org/documentation/#georeplication)**
The Apache Kafka-native inter-cluster replication tool used to mirror event topics across geographically distributed Kafka clusters, enabling cross-cloud and cross-sovereign-zone event propagation.

**[Eclipse Mosquitto](https://mosquitto.org)**
A lightweight open source MQTT broker used at the edge to bridge OT-layer device telemetry into the enterprise event fabric before onward routing to Apache Kafka.

---

## Application Integration Plane — APIs & Mediation

**[Apache Camel](https://camel.apache.org)**
An open source integration framework implementing the Enterprise Integration Patterns. Provides a library of pre-built connectors and a routing DSL for building integration flows that connect heterogeneous applications and protocols.

**[Kong](https://konghq.com)**
An open source API gateway providing cloud-native API management, traffic routing, rate limiting, and plugin-based policy enforcement at the application integration layer.

---

## Control Plane — Governance & Policy

**[Open Policy Agent (OPA)](https://www.openpolicyagent.org)**
A general-purpose policy-as-code engine that evaluates authorisation decisions against declarative Rego policies. Used throughout the Zero-Copy architecture to enforce data access, API routing, and infrastructure provisioning policies at the point of request.

**[Kyverno](https://kyverno.io)**
A Kubernetes-native policy engine that enforces infrastructure-level governance rules as Kubernetes admission controller policies, ensuring sovereign zone infrastructure configurations comply with declared policies.

**[OpenLineage](https://openlineage.io)**
An open standard and API specification for capturing and exchanging data lineage metadata across heterogeneous data systems. Provides the vendor-neutral format through which integration components publish their lineage records to IBM Knowledge Catalog.

---

## Observability & Telemetry

**[OpenTelemetry](https://opentelemetry.io)**
The CNCF standard for distributed tracing, metrics, and log collection. Provides vendor-neutral instrumentation APIs and SDKs so that integration components expose their telemetry in a common format, decoupling instrumentation from the choice of observability backend.

**[Prometheus](https://prometheus.io)**
An open source metrics collection and alerting system widely used in Kubernetes environments to scrape and store time-series performance metrics from integration components.

**[Grafana](https://grafana.com)**
An open source data visualisation and dashboarding platform used to render operational metrics from Prometheus and other observability backends into actionable dashboards.

---

## Identity, Security & Policy

**[SPIFFE](https://spiffe.io)** *(Secure Production Identity Framework for Everyone)*
An open standard for service identity in dynamic, distributed infrastructure. Defines the SVID (SPIFFE Verifiable Identity Document) as a workload identity credential that is independent of network location.

**[SPIRE](https://spiffe.io/docs/latest/spire-about/)** *(SPIFFE Runtime Environment)*
The reference implementation of the SPIFFE specification. Manages workload attestation and SVID issuance, providing each service in the integration fabric with a cryptographically verifiable identity without static credentials.

**[HashiCorp Terraform](https://www.hashicorp.com/en/products/terraform)**
An infrastructure-as-code tool that provisions and manages cloud and on-premises infrastructure through declarative configuration files. Used in the Zero-Copy architecture to ensure sovereign zone infrastructure is provisioned consistently and versioned in source control.

**[HashiCorp Vault](https://www.hashicorp.com/en/products/vault)**
A dynamic secrets management platform that eliminates static credential proliferation by issuing short-lived, scoped credentials to workloads on demand, with a full audit trail of every secret issuance.

---

## Infrastructure & Container Orchestration

**[Kubernetes](https://kubernetes.io)**
The open source container orchestration platform that provides the foundational scheduling, networking, and lifecycle management layer on which Red Hat OpenShift and the broader integration fabric runtime operate.

**[Istio](https://istio.io)**
An open source service mesh that provides mutual TLS enforcement, traffic management, and observability for service-to-service communication within a Kubernetes cluster. The upstream project on which Red Hat OpenShift Service Mesh is built.

**[Envoy](https://www.envoyproxy.io)**
A high-performance open source proxy used as the data plane component within Istio and other service mesh implementations, handling the per-request traffic interception and policy enforcement.

---

## AI & Machine Learning

**[TensorFlow Federated](https://www.tensorflow.org/federated)**
An open source framework for federated machine learning that enables model training to be distributed across data-resident compute nodes without centralising the training data, directly supporting the Zero-Copy federated ML patterns described in this book.

**[PySyft](https://openmined.org)**
An open source Python library for privacy-preserving machine learning that enables encrypted computation and federated learning across data silos.

**[FATE](https://fate.fedai.org)** *(Federated AI Technology Enabler)*
An open source federated learning framework designed for secure computation of machine learning models across organisational boundaries without sharing raw data.

---

## Edge & IoT

**[WebAssembly (WASM)](https://webassembly.org)**
A lightweight, portable binary instruction format that enables computation to be executed in-source at the edge — running analytical or transformation logic within the data-resident environment rather than extracting data for remote processing.

**[MQTT](https://mqtt.org)** *(Message Queuing Telemetry Transport)*
A lightweight publish/subscribe messaging protocol designed for constrained devices and low-bandwidth networks. The standard protocol for OT-layer device telemetry in manufacturing and IoT edge deployments.

**[OPC-UA](https://opcfoundation.org/about/opc-technologies/opc-ua/)** *(OLE for Process Control Unified Architecture)*
An industrial communication protocol and information model standard used to expose process data from industrial control systems and PLCs to the IT integration layer.

---

## Open Standards & Interoperability Protocols

**[FHIR](https://hl7.org/fhir/)** *(HL7 Fast Healthcare Interoperability Resources)*
A RESTful API and data model standard for health data exchange. The primary standard for Zero-Copy patient data access in healthcare architectures, enabling federated query and event-driven integration across clinical systems without copying patient records.

**[HL7 v2](https://www.hl7.org/implement/standards/product_brief.cfm?product_id=185)**
The legacy healthcare messaging standard used by a large proportion of existing hospital information systems. Typically bridged into the FHIR-based integration layer via App Connect mediation.

**[DICOM](https://www.dicomstandard.org)** *(Digital Imaging and Communications in Medicine)*
The international standard for medical imaging data. Governs storage and transmission of imaging data in healthcare environments integrated through the Zero-Copy architecture.

---

## Post-Quantum & Confidential Computing Standards

**[ML-KEM](https://csrc.nist.gov/pubs/fips/203/final)** *(CRYSTALS-Kyber — NIST FIPS 203)*
NIST's finalised post-quantum key encapsulation mechanism, providing quantum-resistant key exchange as a replacement for RSA and elliptic curve Diffie-Hellman in TLS and encrypted communications.

**[ML-DSA](https://csrc.nist.gov/pubs/fips/204/final)** *(CRYSTALS-Dilithium — NIST FIPS 204)*
NIST's finalised post-quantum digital signature algorithm, providing quantum-resistant authentication for certificates, code signing, and API authentication.

**[SLH-DSA](https://csrc.nist.gov/pubs/fips/205/final)** *(SPHINCS+ — NIST FIPS 205)*
NIST's finalised post-quantum hash-based signature standard, providing a conservative, stateless alternative to lattice-based signature schemes.

**[Intel Trust Domain Extensions (TDX)](https://www.intel.com/content/www/us/en/developer/tools/trust-domain-extensions/overview.html)**
Intel's hardware confidential computing technology that creates hardware-isolated Trust Domains (virtual machines) in which workloads execute without the host hypervisor being able to inspect memory contents.

**[AMD Secure Encrypted Virtualisation (SEV-SNP)](https://www.amd.com/en/developer/sev.html)**
AMD's confidential computing technology providing memory encryption and integrity protection for virtual machines, used in sovereign compute deployments requiring hardware-enforced workload isolation.
