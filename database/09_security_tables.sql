CREATE TABLE app_roles (
    role_id               INT PRIMARY KEY,
    role_code             VARCHAR(50) NOT NULL UNIQUE,
    role_name             VARCHAR(100) NOT NULL,
    is_active             BIT NOT NULL DEFAULT 1,
    created_at            DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE app_users (
    user_id               INT PRIMARY KEY,
    username              VARCHAR(100) NOT NULL UNIQUE,
    full_name             VARCHAR(150) NOT NULL,
    email_address         VARCHAR(150) NOT NULL,
    password_hash         VARCHAR(500) NOT NULL,
    is_active             BIT NOT NULL DEFAULT 1,
    created_at            DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE user_roles (
    user_role_id          INT PRIMARY KEY,
    user_id               INT NOT NULL,
    role_id               INT NOT NULL,
    assigned_at           DATETIME NOT NULL DEFAULT GETDATE(),
    assigned_by           VARCHAR(100) NULL,
    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id) REFERENCES app_users(user_id),
    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id) REFERENCES app_roles(role_id)
);

CREATE TABLE api_tokens (
    token_id              INT PRIMARY KEY,
    user_id               INT NOT NULL,
    access_token          VARCHAR(1000) NOT NULL,
    issued_at             DATETIME NOT NULL DEFAULT GETDATE(),
    expires_at            DATETIME NOT NULL,
    is_revoked            BIT NOT NULL DEFAULT 0,
    CONSTRAINT fk_api_tokens_user
        FOREIGN KEY (user_id) REFERENCES app_users(user_id)
);
