CREATE TABLE audit_log (
    audit_id             INT PRIMARY KEY,
    entity_name          VARCHAR(100) NOT NULL,
    entity_id            INT NOT NULL,
    action_type          VARCHAR(50) NOT NULL, -- insert / update / delete / status_change / assignment
    old_value            VARCHAR(MAX) NULL,
    new_value            VARCHAR(MAX) NULL,
    changed_by           VARCHAR(100) NULL,
    changed_at           DATETIME NOT NULL DEFAULT GETDATE(),
    source_system        VARCHAR(100) NULL
);

CREATE TABLE api_request_log (
    request_log_id       INT PRIMARY KEY,
    endpoint_name        VARCHAR(200) NOT NULL,
    http_method          VARCHAR(20) NOT NULL,
    request_payload      VARCHAR(MAX) NULL,
    response_code        INT NOT NULL,
    requested_by         VARCHAR(100) NULL,
    request_time         DATETIME NOT NULL DEFAULT GETDATE()
);
