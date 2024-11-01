import React from 'react';
import clsx from 'clsx';
import Translate from '@docusaurus/Translate';
import type {Props} from '@theme/Admonition/Type/Tip';
import AdmonitionLayout from '@theme/Admonition/Layout';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faLock } from '@fortawesome/free-solid-svg-icons';

const infimaClassName = 'alert alert--cadenas';

const defaultProps = {
icon: <FontAwesomeIcon icon={faLock} />,
title: (
    <Translate
    id="theme.admonition.cadenas"
    description="The default label used for the cadenas admonition (:::cadenas)">
    Cadenas
    </Translate>
),
};

export default function AdmonitionTypeCadenas(props: Props): JSX.Element {
return (
    <AdmonitionLayout
    {...defaultProps}
    {...props}
    className={clsx(infimaClassName, props.className)}>
    {props.children}
    </AdmonitionLayout>
);
}