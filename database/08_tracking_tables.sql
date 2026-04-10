CREATE TABLE qr_tracking_events (
    qr_event_id              INT PRIMARY KEY,
    delivery_id              INT NOT NULL,
    qr_tracking_code         VARCHAR(100) NOT NULL,
    scan_time                DATETIME NOT NULL DEFAULT GETDATE(),
    scan_location            VARCHAR(250) NULL,
    scanned_by               VARCHAR(100) NULL,
    event_type               VARCHAR(50) NOT NULL, -- created / scanned / delivered / failed
    CONSTRAINT fk_qr_tracking_events_delivery
        FOREIGN KEY (delivery_id) REFERENCES delivery_orders(delivery_id)
);

CREATE TABLE gps_tracking_events (
    gps_event_id             INT PRIMARY KEY,
    delivery_id              INT NOT NULL,
    latitude                 DECIMAL(10,6) NOT NULL,
    longitude                DECIMAL(10,6) NOT NULL,
    recorded_at              DATETIME NOT NULL DEFAULT GETDATE(),
    recorded_by              VARCHAR(100) NULL,
    CONSTRAINT fk_gps_tracking_events_delivery
        FOREIGN KEY (delivery_id) REFERENCES delivery_orders(delivery_id)
);

CREATE TABLE notification_log (
    notification_id          INT PRIMARY KEY,
    entity_name              VARCHAR(100) NOT NULL,
    entity_id                INT NOT NULL,
    notification_type        VARCHAR(50) NOT NULL, -- sms / email / push / webhook
    recipient_address        VARCHAR(200) NULL,
    message_body             VARCHAR(MAX) NULL,
    delivery_status          VARCHAR(50) NOT NULL DEFAULT 'pending',
    created_at               DATETIME NOT NULL DEFAULT GETDATE(),
    sent_at                  DATETIME NULL
);
